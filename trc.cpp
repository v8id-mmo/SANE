#include "trc.h"
#include <QDebug>
#include <QTextDocument>
#include <stdio.h>
#include <QStandardPaths>


ClascExec::ClascExec(int argc, char *argv[]) {
    app = new QCoreApplication(argc, argv);
    app->setOrganizationDomain("lemonspawn.com");
    app->setApplicationName("TRSE");
    // first values are "trse" and "-cli", so start at 2
    for (int i=2;i<argc;i++) {
        auto s = QString(argv[i]);
        if (s.startsWith("--")) {
            QString opt = s.remove("--");
            if (opt.toLower()=="define") {
                if (i==argc-1) {
                    qInfo() << "Error : define requires a parameter '--define X86'";
                    m_hasError = true;
                    break;
                }
                i+=1;
                auto arg = QString(argv[i]);
                m_options[s] = QStringList()<<arg;
            }
        }
        else
        {
            m_args.append(s);
            QStringList l = s.split("=");
            if (l.count()!=2) {
                qInfo() << "Error : parameters must be of the format  'p1=someting'";
                m_hasError = true;
                break;
            }
            else
                m_vals[l[0].toLower().trimmed()] = l[1].trimmed();
        }
    }
}

void ClascExec::RequireParam(QString param)
{
    if (!m_vals.contains(param))
        throw QString("Parameter '"+param+"' is required.");
}

void ClascExec::RequireFile(QString param)
{
    RequireParam(param);
    if (!QFile::exists(m_vals[param]))
      throw QString("Could not find file: " + m_vals[param]);
}

int ClascExec::Perform()
{
    if (m_hasError)
        return 1;
    m_settings = QSharedPointer<CIniFile>(new CIniFile());
    m_project = QSharedPointer<CIniFile>(new CIniFile());


    try {
        RequireFile("input_file");
        RequireParam("op");
        if (!m_vals.contains("assemble"))
            m_vals["assemble"] = "yes";

        QString op = m_vals["op"].toLower();
        if (m_vals.contains("output_file"))
            m_outputFile = m_vals["output_file"];

        if (op=="project") {
//            RequireFile("settings");
            RequireFile("project");
            if (m_vals.contains("settings")) {
                m_settings->Load(m_vals["settings"]);
            }
            else {
                auto path = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
                QString iniFileName = path +QDir::separator()+ "trse.ini";

                if (QFile::exists(iniFileName))
                    m_settings->Load(iniFileName);
                else {
                    Out("Could not load TRSE settings! Please make sure you have started TRSE as a windowed application at least once before using the CLI.");
                    return 1;
                }
            }
            // Set some settings params
            // Turn off threaded compliation
            m_settings->setFloat("compile_thread",0);



            m_project->Load(m_vals["project"]);
            m_failure = CompileFromProject(m_vals["input_file"],m_vals["assemble"]=="yes");
        }
        else
            if (op=="orgasm") {
            m_failure= Assemble(m_vals["input_file"]);
        }
        else {
            m_failure = 1;
            Out("Unknown operation: " +op);
        }

    }
    catch (QString s) {
        PrintUsage();
        Out("Fatal error:");
        Out(s);
        return 1;
    }

    if (m_failure) {
        QTextDocument doc;
        doc.setHtml( m_builder->getOutput() );
        Out(doc.toPlainText());
    }
    return m_failure;
}

int ClascExec::CompileFromProject(QString sourceFile, bool assemble)
{
    QString system = m_project->getString("system");
    Out("Compiling '"+sourceFile+"' for system: " +system);
    Syntax::s.Init(AbstractSystem::SystemFromString(system),m_settings, m_project);
    QString source = Util::loadTextFile(sourceFile);
//    Out(QDir::currentPath());
    m_builder = new SourceBuilder(m_settings,m_project, QDir::currentPath()+"/", sourceFile);
    m_builder->m_options = m_options;
    m_failure=0;
    if (!m_builder->Build(source)) {
        m_failure=1;
    }
    else {
        if (assemble) {
            m_builder->Assemble();
            m_failure = !m_builder->m_assembleSuccess;
        }
    }
    if (!m_failure && assemble && m_outputFile!="") {
        // Only the default (unset/"prg") output_type produces a plain
        // .prg as its own final artifact; "crt"/"d64" post-process the
        // .prg further into a different file (or files) of their own, so
        // renaming it out from under them would just misname an
        // intermediate rather than the real output.
        QString outputType = m_project->getString("output_type");
        if (outputType=="" || outputType=="prg") {
            QString producedPrg = m_builder->m_filename+".prg";
            if (QFile::exists(producedPrg))
                QFile::rename(producedPrg, m_outputFile);
        }
    }
    if (m_failure) {
        QTextDocument doc;
        doc.setHtml( m_builder->getOutput() );
        Out(doc.toPlainText());
    }
    else if (!ErrorHandler::e.m_teOut.isEmpty()) {
        // Warnings (e.g. @raisewarning, the rand/getkey deprecation notices)
        // are only ever queued into ErrorHandler::e.m_teOut, otherwise
        // meant for the removed GUI's own output pane; a successful compile
        // needs its own print here since the failure branch above is the
        // only other place that ever reads it.
        QTextDocument doc;
        doc.setHtml( ErrorHandler::e.m_teOut );
        Out(doc.toPlainText());
    }
    return m_failure;
}

int ClascExec::Assemble(QString file)
{
    Orgasm orgAsm;
    QString filename = file.split(".")[0] + ".prg";
    if (m_outputFile!="")
        filename = m_outputFile;
/*    for(QString k: symTab->m_constants.keys()) {
        orgAsm.m_constants[k] = Util::numToHex(symTab->m_constants[k]->m_value->m_fVal);
    }
*/
    Out("Assembling file:'"+filename);
    orgAsm.Assemble(file, filename);
    Out(orgAsm.m_output);
    if (orgAsm.m_output.contains("Complete"))
        return 0;

    return 1;
}

void ClascExec::PrintUsage()
{
    Out("Welcome to the TRSE CLI (command-line interface) assembler/compiler!");
    Out("");
    Out("Usage: ");
    Out("");
    Out("trse -cli op=[ operation types ] input_file=[ source file ] output_file=[ optional output file ].... [ type specific operation parameters ]");
    Out("Valid operation types are: project, orgasm");
    Out("");
    Out("Examples: ");
    Out("  compile + assemble a project with a main source file: ");
    Out("       trc op=project project=myDemo.trse input_file=main_demo.ras");
    Out("   Use a custom settings file: ");
    Out("       trc op=project settings=trse.ini project=myDemo.trse input_file=main_demo.ras");
    Out("   To only compile and not perform any assembling, use the 'assemble=no' option  ");
    Out("       trc project=myDemo.trse input_file=main_demo.ras no_assembling");
    Out("");
    Out("  Use OrgAsm to assemble an .asm to .prg: ");
    Out("     trc op=orgasm   input_file=main_demo.asm");
    Out("");;
}

void ClascExec::Out(QString m)
{
 //   qInfo() << m << endl;
//    printf(m.toStdString().c_str());
    std::cout << m.toStdString() << std::endl;
}

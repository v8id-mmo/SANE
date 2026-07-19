#include "factorycompiler.h"

FactoryCompiler::FactoryCompiler()
{

}

Compiler *FactoryCompiler::CreateCompiler(QSharedPointer<CIniFile> ini, QSharedPointer<CIniFile> pIni)
{
    return new Compiler6502(ini,pIni);
}

#ifndef FACTORYCOMPILER_H
#define FACTORYCOMPILER_H

#include "compiler6502.h"

class FactoryCompiler
{
public:
    FactoryCompiler();
    static Compiler* CreateCompiler(QSharedPointer<CIniFile> ini, QSharedPointer<CIniFile> pIni);
};

#endif // FACTORYCOMPILER_H

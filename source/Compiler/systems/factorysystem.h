#ifndef FACTORYSYSTEM_H
#define FACTORYSYSTEM_H

#include "systemmos6502.h"
#include "systemc64.h"
#include "source/LeLib/util/cinifile.h"

class FactorySystem
{
public:
    FactorySystem();

    static AbstractSystem* Create(AbstractSystem::System type,QSharedPointer<CIniFile> settings, QSharedPointer<CIniFile> proj);


};

#endif // FACTORYSYSTEM_H

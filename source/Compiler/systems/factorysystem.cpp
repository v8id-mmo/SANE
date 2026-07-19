
#include "factorysystem.h"

FactorySystem::FactorySystem()
{

}

AbstractSystem *FactorySystem::Create(AbstractSystem::System type, QSharedPointer<CIniFile> settings, QSharedPointer<CIniFile> proj) {
    if (type==AbstractSystem::C64)
        return new SystemC64(settings, proj);

    return nullptr;
}

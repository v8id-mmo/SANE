#include "factorymethods.h"

FactoryMethods::FactoryMethods()
{

}

QSharedPointer<AbstractMethods> FactoryMethods::CreateMethods(AbstractSystem::System s)
{
    return QSharedPointer<Methods6502C64>(new Methods6502C64);
}

#ifndef FACTORYMETHODS_H
#define FACTORYMETHODS_H

#include <QSharedPointer>
#include "methods6502.h"
#include "methods6502c64.h"

class FactoryMethods
{
public:
    FactoryMethods();

    static QSharedPointer<AbstractMethods> CreateMethods(AbstractSystem::System s);
};

#endif // FACTORYMETHODS_H

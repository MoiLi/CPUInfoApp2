#include "cpuinfo.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QJsonObject>

CPUInfo::CPUInfo(QObject *parent) : QObject(parent)
{
    // Do nothing.
}

void CPUInfo::setSource(QString source)
{
    if (source != mSource) {
        mSource = source;
    }
}

/**
 * Begin to load the cpu infos,when it is done, it will emit the dataChanged signal.
 *
 * @brief CPUInfo::startLoadCPUInfo
 */
void CPUInfo::startLoadCPUInfo()
{
    if (mSource.isEmpty()) {
        qWarning() << "Source does not exits: " << mSource;
        return;
    }

    QVariantList data;
   // QVariantMap current;
    QJsonObject current;
    QVariant xx;

    QFile file(mSource);
    if(!file.exists()) {
        qWarning() << "File does not exits: " << mSource;
        return;
    }

    // Open file.
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        QString line = stream.readLine();

        // Read each line from the source file.
        // a processor section start with processor and end with a empty line.
        while (!line.isNull()) {
            // Find a empty line, means, a processor section is finished.
            if (line.isEmpty()) {

           //   xx.setValue(current);
             data.append(current);

            } else {
                QStringList infos = line.split(":");

                if (infos.length() == 2) {
                    QString name = infos.at(0).trimmed();
                    QString value = infos.at(1).trimmed();

//                    if (str.isEmpty()) {
//                        str = "Unknown";
//                    }

                   current.insert(name, value);
                   // current->setProperty(name.toStdString().c_str(),value);
                }
            }
            line = stream.readLine();
        }
    }

    // Close file.
    file.close();


    // notify UI.


    emit dataChanged(data);
}

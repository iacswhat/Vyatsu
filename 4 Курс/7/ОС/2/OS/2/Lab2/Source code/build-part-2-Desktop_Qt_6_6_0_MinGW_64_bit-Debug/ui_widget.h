/********************************************************************************
** Form generated from reading UI file 'widget.ui'
**
** Created by: Qt User Interface Compiler version 6.6.0
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_WIDGET_H
#define UI_WIDGET_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QGraphicsView>
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSlider>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Widget
{
public:
    QVBoxLayout *verticalLayout;
    QLabel *label_10;
    QGraphicsView *graphicsView;
    QHBoxLayout *horizontalLayout_2;
    QLabel *label_3;
    QLabel *label;
    QSlider *speedSlider;
    QLabel *label_2;
    QHBoxLayout *horizontalLayout_3;
    QLabel *label_4;
    QLabel *label_5;
    QSlider *speedSlider2;
    QLabel *label_6;
    QHBoxLayout *horizontalLayout_4;
    QLabel *label_8;
    QLabel *label_7;
    QSlider *speedSlider3;
    QLabel *label_9;
    QHBoxLayout *horizontalLayout;
    QSpacerItem *horizontalSpacer_2;
    QPushButton *startButton;
    QPushButton *stopButton;
    QSpacerItem *horizontalSpacer;

    void setupUi(QWidget *Widget)
    {
        if (Widget->objectName().isEmpty())
            Widget->setObjectName("Widget");
        Widget->resize(621, 631);
        verticalLayout = new QVBoxLayout(Widget);
        verticalLayout->setSpacing(6);
        verticalLayout->setContentsMargins(11, 11, 11, 11);
        verticalLayout->setObjectName("verticalLayout");
        label_10 = new QLabel(Widget);
        label_10->setObjectName("label_10");

        verticalLayout->addWidget(label_10);

        graphicsView = new QGraphicsView(Widget);
        graphicsView->setObjectName("graphicsView");

        verticalLayout->addWidget(graphicsView);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setSpacing(6);
        horizontalLayout_2->setObjectName("horizontalLayout_2");
        label_3 = new QLabel(Widget);
        label_3->setObjectName("label_3");

        horizontalLayout_2->addWidget(label_3);

        label = new QLabel(Widget);
        label->setObjectName("label");

        horizontalLayout_2->addWidget(label);

        speedSlider = new QSlider(Widget);
        speedSlider->setObjectName("speedSlider");
        speedSlider->setValue(50);
        speedSlider->setOrientation(Qt::Horizontal);

        horizontalLayout_2->addWidget(speedSlider);

        label_2 = new QLabel(Widget);
        label_2->setObjectName("label_2");

        horizontalLayout_2->addWidget(label_2);


        verticalLayout->addLayout(horizontalLayout_2);

        horizontalLayout_3 = new QHBoxLayout();
        horizontalLayout_3->setSpacing(6);
        horizontalLayout_3->setObjectName("horizontalLayout_3");
        label_4 = new QLabel(Widget);
        label_4->setObjectName("label_4");

        horizontalLayout_3->addWidget(label_4);

        label_5 = new QLabel(Widget);
        label_5->setObjectName("label_5");

        horizontalLayout_3->addWidget(label_5);

        speedSlider2 = new QSlider(Widget);
        speedSlider2->setObjectName("speedSlider2");
        speedSlider2->setValue(50);
        speedSlider2->setOrientation(Qt::Horizontal);

        horizontalLayout_3->addWidget(speedSlider2);

        label_6 = new QLabel(Widget);
        label_6->setObjectName("label_6");

        horizontalLayout_3->addWidget(label_6);


        verticalLayout->addLayout(horizontalLayout_3);

        horizontalLayout_4 = new QHBoxLayout();
        horizontalLayout_4->setSpacing(6);
        horizontalLayout_4->setObjectName("horizontalLayout_4");
        label_8 = new QLabel(Widget);
        label_8->setObjectName("label_8");

        horizontalLayout_4->addWidget(label_8);

        label_7 = new QLabel(Widget);
        label_7->setObjectName("label_7");

        horizontalLayout_4->addWidget(label_7);

        speedSlider3 = new QSlider(Widget);
        speedSlider3->setObjectName("speedSlider3");
        speedSlider3->setValue(50);
        speedSlider3->setOrientation(Qt::Horizontal);

        horizontalLayout_4->addWidget(speedSlider3);

        label_9 = new QLabel(Widget);
        label_9->setObjectName("label_9");

        horizontalLayout_4->addWidget(label_9);


        verticalLayout->addLayout(horizontalLayout_4);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setSpacing(6);
        horizontalLayout->setObjectName("horizontalLayout");
        horizontalLayout->setSizeConstraint(QLayout::SetDefaultConstraint);
        horizontalSpacer_2 = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer_2);

        startButton = new QPushButton(Widget);
        startButton->setObjectName("startButton");

        horizontalLayout->addWidget(startButton);

        stopButton = new QPushButton(Widget);
        stopButton->setObjectName("stopButton");

        horizontalLayout->addWidget(stopButton);

        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);


        verticalLayout->addLayout(horizontalLayout);


        retranslateUi(Widget);

        QMetaObject::connectSlotsByName(Widget);
    } // setupUi

    void retranslateUi(QWidget *Widget)
    {
        Widget->setWindowTitle(QCoreApplication::translate("Widget", "\320\227\320\260\320\264\320\260\321\207\320\260 \320\276 \320\272\321\203\321\200\320\270\320\273\321\214\321\211\320\270\320\272\320\260\321\205", nullptr));
        label_10->setText(QCoreApplication::translate("Widget", "\320\227\320\260\320\264\320\260\321\207\320\260 \320\276 \320\272\321\203\321\200\320\270\320\273\321\214\321\211\320\270\320\272\320\260\321\205 \321\201 \320\277\320\276\320\274\320\276\321\211\321\214\321\216 \320\274\321\214\321\216\321\202\320\265\320\272\321\201\320\260", nullptr));
        label_3->setText(QCoreApplication::translate("Widget", "\320\232\321\203\321\200\320\270\320\273\321\214\321\211\320\270\320\272 1", nullptr));
        label->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label_2->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        label_4->setText(QCoreApplication::translate("Widget", "\320\232\321\203\321\200\320\270\320\273\321\214\321\211\320\270\320\272 2", nullptr));
        label_5->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label_6->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        label_8->setText(QCoreApplication::translate("Widget", "\320\232\321\203\321\200\320\270\320\273\321\214\321\211\320\270\320\272 3", nullptr));
        label_7->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label_9->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        startButton->setText(QCoreApplication::translate("Widget", "\320\237\321\203\321\201\320\272", nullptr));
        stopButton->setText(QCoreApplication::translate("Widget", "\320\241\321\202\320\276\320\277", nullptr));
    } // retranslateUi

};

namespace Ui {
    class Widget: public Ui_Widget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WIDGET_H

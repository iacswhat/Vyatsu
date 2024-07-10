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
#include <QtWidgets/QHBoxLayout>
#include <QtWidgets/QLabel>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSlider>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QTextEdit>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>

QT_BEGIN_NAMESPACE

class Ui_Widget
{
public:
    QWidget *verticalLayoutWidget;
    QVBoxLayout *verticalLayout;
    QLabel *label_10;
    QLabel *label_3;
    QLabel *label_4;
    QHBoxLayout *horizontalLayout_3;
    QVBoxLayout *verticalLayout_3;
    QLabel *label;
    QTextEdit *textEdit;
    QVBoxLayout *verticalLayout_4;
    QLabel *label_11;
    QTextEdit *textEdit_2;
    QVBoxLayout *verticalLayout_2;
    QLabel *label_2;
    QHBoxLayout *horizontalLayout_2;
    QLabel *label_5;
    QSlider *slider1;
    QLabel *label_6;
    QLabel *label_7;
    QHBoxLayout *horizontalLayout_4;
    QLabel *label_8;
    QSlider *slider2;
    QLabel *label_9;
    QHBoxLayout *horizontalLayout;
    QPushButton *pushButton;
    QPushButton *pushButton_2;
    QPushButton *pushButton_4;
    QSpacerItem *horizontalSpacer;
    QPushButton *pushButton_3;

    void setupUi(QWidget *Widget)
    {
        if (Widget->objectName().isEmpty())
            Widget->setObjectName("Widget");
        Widget->resize(450, 450);
        Widget->setMinimumSize(QSize(450, 450));
        Widget->setMaximumSize(QSize(450, 450));
        verticalLayoutWidget = new QWidget(Widget);
        verticalLayoutWidget->setObjectName("verticalLayoutWidget");
        verticalLayoutWidget->setGeometry(QRect(10, 10, 431, 431));
        verticalLayout = new QVBoxLayout(verticalLayoutWidget);
        verticalLayout->setObjectName("verticalLayout");
        verticalLayout->setContentsMargins(0, 0, 0, 0);
        label_10 = new QLabel(verticalLayoutWidget);
        label_10->setObjectName("label_10");

        verticalLayout->addWidget(label_10);

        label_3 = new QLabel(verticalLayoutWidget);
        label_3->setObjectName("label_3");
        label_3->setTextFormat(Qt::AutoText);
        label_3->setScaledContents(false);
        label_3->setWordWrap(true);

        verticalLayout->addWidget(label_3);

        label_4 = new QLabel(verticalLayoutWidget);
        label_4->setObjectName("label_4");
        label_4->setMaximumSize(QSize(430, 16777215));
        label_4->setWordWrap(true);

        verticalLayout->addWidget(label_4);

        horizontalLayout_3 = new QHBoxLayout();
        horizontalLayout_3->setObjectName("horizontalLayout_3");
        verticalLayout_3 = new QVBoxLayout();
        verticalLayout_3->setObjectName("verticalLayout_3");
        label = new QLabel(verticalLayoutWidget);
        label->setObjectName("label");

        verticalLayout_3->addWidget(label);

        textEdit = new QTextEdit(verticalLayoutWidget);
        textEdit->setObjectName("textEdit");
        textEdit->setEnabled(true);
        textEdit->setReadOnly(true);

        verticalLayout_3->addWidget(textEdit);


        horizontalLayout_3->addLayout(verticalLayout_3);

        verticalLayout_4 = new QVBoxLayout();
        verticalLayout_4->setObjectName("verticalLayout_4");
        label_11 = new QLabel(verticalLayoutWidget);
        label_11->setObjectName("label_11");

        verticalLayout_4->addWidget(label_11);

        textEdit_2 = new QTextEdit(verticalLayoutWidget);
        textEdit_2->setObjectName("textEdit_2");
        textEdit_2->setEnabled(true);
        textEdit_2->setReadOnly(true);

        verticalLayout_4->addWidget(textEdit_2);


        horizontalLayout_3->addLayout(verticalLayout_4);


        verticalLayout->addLayout(horizontalLayout_3);

        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setObjectName("verticalLayout_2");
        label_2 = new QLabel(verticalLayoutWidget);
        label_2->setObjectName("label_2");

        verticalLayout_2->addWidget(label_2);

        horizontalLayout_2 = new QHBoxLayout();
        horizontalLayout_2->setObjectName("horizontalLayout_2");
        label_5 = new QLabel(verticalLayoutWidget);
        label_5->setObjectName("label_5");

        horizontalLayout_2->addWidget(label_5);

        slider1 = new QSlider(verticalLayoutWidget);
        slider1->setObjectName("slider1");
        slider1->setAcceptDrops(false);
        slider1->setStyleSheet(QString::fromUtf8(""));
        slider1->setMinimum(10);
        slider1->setMaximum(100);
        slider1->setSingleStep(1);
        slider1->setPageStep(1);
        slider1->setValue(55);
        slider1->setSliderPosition(55);
        slider1->setTracking(true);
        slider1->setOrientation(Qt::Horizontal);
        slider1->setInvertedAppearance(true);
        slider1->setInvertedControls(false);

        horizontalLayout_2->addWidget(slider1);

        label_6 = new QLabel(verticalLayoutWidget);
        label_6->setObjectName("label_6");

        horizontalLayout_2->addWidget(label_6);


        verticalLayout_2->addLayout(horizontalLayout_2);

        label_7 = new QLabel(verticalLayoutWidget);
        label_7->setObjectName("label_7");

        verticalLayout_2->addWidget(label_7);

        horizontalLayout_4 = new QHBoxLayout();
        horizontalLayout_4->setObjectName("horizontalLayout_4");
        label_8 = new QLabel(verticalLayoutWidget);
        label_8->setObjectName("label_8");

        horizontalLayout_4->addWidget(label_8);

        slider2 = new QSlider(verticalLayoutWidget);
        slider2->setObjectName("slider2");
        slider2->setMinimum(10);
        slider2->setMaximum(100);
        slider2->setPageStep(1);
        slider2->setValue(55);
        slider2->setOrientation(Qt::Horizontal);
        slider2->setInvertedAppearance(true);

        horizontalLayout_4->addWidget(slider2);

        label_9 = new QLabel(verticalLayoutWidget);
        label_9->setObjectName("label_9");

        horizontalLayout_4->addWidget(label_9);


        verticalLayout_2->addLayout(horizontalLayout_4);


        verticalLayout->addLayout(verticalLayout_2);

        horizontalLayout = new QHBoxLayout();
        horizontalLayout->setObjectName("horizontalLayout");
        pushButton = new QPushButton(verticalLayoutWidget);
        pushButton->setObjectName("pushButton");

        horizontalLayout->addWidget(pushButton);

        pushButton_2 = new QPushButton(verticalLayoutWidget);
        pushButton_2->setObjectName("pushButton_2");
        pushButton_2->setEnabled(false);

        horizontalLayout->addWidget(pushButton_2);

        pushButton_4 = new QPushButton(verticalLayoutWidget);
        pushButton_4->setObjectName("pushButton_4");
        pushButton_4->setEnabled(false);

        horizontalLayout->addWidget(pushButton_4);

        horizontalSpacer = new QSpacerItem(40, 20, QSizePolicy::Expanding, QSizePolicy::Minimum);

        horizontalLayout->addItem(horizontalSpacer);

        pushButton_3 = new QPushButton(verticalLayoutWidget);
        pushButton_3->setObjectName("pushButton_3");

        horizontalLayout->addWidget(pushButton_3);


        verticalLayout->addLayout(horizontalLayout);


        retranslateUi(Widget);

        QMetaObject::connectSlotsByName(Widget);
    } // setupUi

    void retranslateUi(QWidget *Widget)
    {
        Widget->setWindowTitle(QCoreApplication::translate("Widget", "Task1", nullptr));
        label_10->setText(QCoreApplication::translate("Widget", "\320\220\320\273\320\263\320\276\321\200\320\270\321\202\320\274 \320\237\320\265\321\202\320\265\321\200\321\201\320\276\320\275\320\260", nullptr));
        label_3->setText(QCoreApplication::translate("Widget", "\320\237\320\276\321\202\320\276\320\272 1: \320\267\320\260\320\277\320\270\321\201\321\213\320\262\320\260\320\265\321\202 \320\262 \321\204\320\260\320\271\320\273 \321\207\320\270\321\201\320\273\320\260 (\320\264\320\276 100), \320\275\320\265 \320\264\320\265\320\273\321\217\321\211\320\270\320\265\321\201\321\217 \320\275\320\260 3.", nullptr));
        label_4->setText(QCoreApplication::translate("Widget", "\320\237\320\276\321\202\320\276\320\272 2: \321\201\321\207\320\270\321\202\321\213\320\262\320\260\320\265\321\202 \320\270\320\267 \321\204\320\260\320\271\320\273\320\260 \321\207\320\270\321\201\320\273\320\260, \320\277\321\200\320\276\320\262\320\265\321\200\321\217\320\265\321\202, \321\207\320\265\321\202\320\275\321\213\320\265 \320\276\320\275\320\270 \320\270\320\273\320\270 \320\275\320\265\321\202, \320\265\321\201\320\273\320\270 \320\264\320\260 \342\200\223 \321\203\320\264\320\260\320\273\321\217\320\265\321\202 \320\270\321\205 \320\270\320\267 \321\204\320\260\320\271\320\273\320\260", nullptr));
        label->setText(QCoreApplication::translate("Widget", "\320\237\320\276\321\202\320\276\320\272 1:", nullptr));
        label_11->setText(QCoreApplication::translate("Widget", "\320\237\320\276\321\202\320\276\320\272 2:", nullptr));
        label_2->setText(QCoreApplication::translate("Widget", "\320\237\320\276\321\202\320\276\320\272 1", nullptr));
        label_5->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label_6->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        label_7->setText(QCoreApplication::translate("Widget", "\320\237\320\276\321\202\320\276\320\272 2", nullptr));
        label_8->setText(QCoreApplication::translate("Widget", "\320\234\320\265\320\264\320\273\320\265\320\275\320\275\320\276", nullptr));
        label_9->setText(QCoreApplication::translate("Widget", "\320\221\321\213\321\201\321\202\321\200\320\276", nullptr));
        pushButton->setText(QCoreApplication::translate("Widget", "\320\241\321\202\320\260\321\200\321\202", nullptr));
        pushButton_2->setText(QCoreApplication::translate("Widget", "\320\241\321\202\320\276\320\277", nullptr));
        pushButton_4->setText(QCoreApplication::translate("Widget", "\320\241\320\261\321\200\320\276\321\201", nullptr));
        pushButton_3->setText(QCoreApplication::translate("Widget", "\320\227\320\260\320\272\321\200\321\213\321\202\321\214", nullptr));
    } // retranslateUi

};

namespace Ui {
    class Widget: public Ui_Widget {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_WIDGET_H

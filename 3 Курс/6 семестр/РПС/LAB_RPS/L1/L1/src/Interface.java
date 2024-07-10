import javax.swing.*;
import java.awt.*;
import java.math.BigInteger;

public class Interface {

    private JTextField mainNum = new JTextField("");
    private JTextField mainDen = new JTextField("");

    private JTextField secNum = new JTextField("");
    private JTextField secDen = new JTextField("");

    private JTextField result  = new JTextField("");
    private JButton calc = new JButton("Calc");
    private JLabel wrong = new JLabel("Пожалуйста, введите дроби!");

    String operations[] = {"Сложение", "Вычитание", "Умножение", "Деление"};
    private JComboBox oper = new JComboBox(operations);


    private BigFraction mainFraction = new BigFraction();
    private BigFraction secFraction = new BigFraction();

    public Interface() {
        JFrame window = new JFrame("BigFraction");
        window.setSize(950,400);
        window.setLocation(500,300);
        window.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JLabel labMain = new JLabel("Первая дробь");
        labMain.setBounds(70,100,100,30);
        window.add(labMain);

        mainNum.setBounds(200, 100, 200, 30);
        mainDen.setBounds(450, 100, 200, 30);
        window.add(mainNum);
        window.add(mainDen);

        JLabel labSec = new JLabel("Вторая дробь");
        labSec.setBounds(70,150,100,30);
        window.add(labSec);

        secNum.setBounds(200, 150, 200, 30);
        secDen.setBounds(450, 150, 200, 30);
        window.add(secNum);
        window.add(secDen);

        JLabel labRes = new JLabel("Результат");
        labRes.setBounds(70,200,80,30);
        window.add(labRes);

        result.setBounds(200, 200, 450, 30);
        result.setEnabled(false);
        window.add(result);

        calc.setBounds(200, 250, 150, 30);
        calc.setEnabled(true);
        window.add(calc);

        wrong.setBounds(200, 300, 350, 30);
        window.add(wrong);

        oper.setBounds(700, 100, 100,30);
        window.add(oper);

        window.setLayout(null);
        window.setVisible(true);
    }

    private String num = "";
    private String den = "";

    private BigFraction res = new BigFraction();

    public void mainProc() {
        calc.addActionListener(e -> {
            if (!mainNum.getText().replaceAll("[^0-9-]", "").equals("") &&
                    !mainDen.getText().replaceAll("[^0-9-]", "").equals("") &&
                    !secNum.getText().replaceAll("[^0-9-]", "").equals("") &&
                    !secDen.getText().replaceAll("[^0-9-]", "").equals("")) {

                wrong.setText("Пожалуйста, введите дроби!");

                String minus = "-";

                num = mainNum.getText();
                if (num.charAt(0) != '-') {
                    num = num.replaceAll("[^0-9]", "");
                }
                else {
                    if (num.charAt(0) == '-') {
                        num = num.replaceAll("[^0-9]", "");
                        num = minus + num;
                    }
                }
                mainNum.setText(num);

                den = mainDen.getText();
                if (den.charAt(0) != '-') {
                    den = den.replaceAll("[^0-9]", "");
                }
                else {
                    if (den.charAt(0) == '-') {
                        den = den.replaceAll("[^0-9]", "");
                        den = minus + den;
                    }
                }
                mainDen.setText(den);

                mainFraction = new BigFraction(new BigInteger(num), new BigInteger(den));


                num = secNum.getText();
                if (num.charAt(0) != '-') {
                    num = num.replaceAll("[^0-9]", "");
                }
                else {
                    if (num.charAt(0) == '-') {
                        num = num.replaceAll("[^0-9]", "");
                        num = minus + num;
                    }
                }
                secNum.setText(num);


                den = secDen.getText();
                if (den.charAt(0) != '-') {
                    den = den.replaceAll("[^0-9]", "");
                }
                else {
                    if (den.charAt(0) == '-') {
                        den = den.replaceAll("[^0-9]", "");
                        den = minus + den;
                    }
                }
                secDen.setText(den);

                secFraction = new BigFraction(new BigInteger(num), new BigInteger(den));

                switch (oper.getSelectedIndex()) {
                    case 0 -> {
                        res = mainFraction.sum(secFraction);
                        result.setText(res.toString(10));
                        wrong.setForeground(Color.green);


                    }
                    case 1 -> {
                        res = mainFraction.sub(secFraction);
                        result.setText(res.toString(10));
                        wrong.setForeground(Color.green);
                    }
                    case 2 -> {
                        res = mainFraction.mul(secFraction);
                        result.setText(res.toString(10));
                        wrong.setForeground(Color.green);
                    }
                    case 3 -> {
                        res = mainFraction.div(secFraction);
                        if (res != null) {
                            result.setText(res.toString(10));
                            wrong.setForeground(Color.green);
                        }
                        else {
                            result.setText("");
                            wrong.setForeground(Color.red);
                            wrong.setText("Деление на 0!!!");
                        }
                    }

                }
            }
            else {
                wrong.setForeground(Color.red);
            }
        });
    }

}

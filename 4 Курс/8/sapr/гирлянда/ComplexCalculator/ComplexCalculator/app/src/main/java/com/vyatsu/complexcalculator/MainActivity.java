package com.vyatsu.complexcalculator;

import android.annotation.SuppressLint;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ToggleButton;

import java.util.function.BiFunction;
import java.util.function.Function;

public class MainActivity extends AppCompatActivity {

    private Button addButton;
    private Button subButton;
    private Button mulButton;
    private Button divButton;

    private EditText firstReal;
    private EditText firstImaginary;
    private EditText secondReal;
    private EditText secondImaginary;
    private EditText resultReal;
    private EditText resultImaginary;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        addButton = findViewById(R.id.addButton);
        subButton = findViewById(R.id.subButton);
        mulButton = findViewById(R.id.mulButton);
        divButton = findViewById(R.id.divButton);

        firstReal = findViewById(R.id.firstReal);
        firstImaginary = findViewById(R.id.firstImaginary);
        secondReal = findViewById(R.id.secondReal);
        secondImaginary = findViewById(R.id.secondImaginary);
        resultReal = findViewById(R.id.resultReal);
        resultImaginary = findViewById(R.id.resultImaginary);

        addButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createResult(new TwoFunction<ComplexNumber, ComplexNumber, ComplexNumber>(){
                    @Override
                    public ComplexNumber apply(ComplexNumber operand1, ComplexNumber operand2) {
                        return ComplexNumber.addition(operand1, operand2);
                    }
                });
            }
        });

        subButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createResult(new TwoFunction<ComplexNumber, ComplexNumber, ComplexNumber>(){
                    @Override
                    public ComplexNumber apply(ComplexNumber operand1, ComplexNumber operand2) {
                        return ComplexNumber.subtraction(operand1, operand2);
                    }
                });
            }
        });

        mulButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createResult(new TwoFunction<ComplexNumber, ComplexNumber, ComplexNumber>(){
                    @Override
                    public ComplexNumber apply(ComplexNumber operand1, ComplexNumber operand2) {
                        return ComplexNumber.multiplication(operand1, operand2);
                    }
                });
            }
        });

        divButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                createResult(new TwoFunction<ComplexNumber, ComplexNumber, ComplexNumber>(){
                    @Override
                    public ComplexNumber apply(ComplexNumber operand1, ComplexNumber operand2) {
                        return ComplexNumber.division(operand1, operand2);
                    }
                });
            }
        });
    }

    @SuppressLint("SetTextI18n")
    private void createResult(TwoFunction<ComplexNumber, ComplexNumber, ComplexNumber> operation){
        ComplexNumber operand1;
        ComplexNumber operand2;
        try {
            operand1 = new ComplexNumber(Double.parseDouble(firstReal.getText().toString()),
                    Double.parseDouble(firstImaginary.getText().toString())
            );
            operand2 = new ComplexNumber(Double.parseDouble(secondReal.getText().toString()),
                    Double.parseDouble(secondImaginary.getText().toString())
            );
        } catch (NumberFormatException e) {
            resultReal.setText("");
            resultImaginary.setText("");
            return;
        }

        ComplexNumber result = operation.apply(operand1, operand2);
        resultReal.setText(result.getReal().toString());
        resultImaginary.setText(result.getImaginary().toString());
    }
}

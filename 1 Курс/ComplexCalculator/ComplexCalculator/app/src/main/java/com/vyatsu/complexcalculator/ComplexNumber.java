package com.vyatsu.complexcalculator;


import java.util.Objects;

public class ComplexNumber {
    private Double real;
    private Double imaginary;

    public ComplexNumber() {
        this(0, 0);
    }

    public ComplexNumber(double real, double imaginary) {
        this.real = real;
        this.imaginary = imaginary;
    }

    public Double getReal() {
        return real;
    }

    public void setReal(Double real) {
        this.real = real;
    }

    public Double getImaginary() {
        return imaginary;
    }

    public void setImaginary(Double imaginary) {
        this.imaginary = imaginary;
    }

    public static ComplexNumber addition(ComplexNumber operand1, ComplexNumber operand2){
        double real = operand1.getReal() + operand2.getReal();
        double imaginary = operand1.getImaginary() + operand2.getImaginary();

        return  new ComplexNumber(real, imaginary);
    }

    public static ComplexNumber subtraction(ComplexNumber operand1, ComplexNumber operand2){
        double real = operand1.getReal() - operand2.getReal();
        double imaginary = operand1.getImaginary() - operand2.getImaginary();

        return  new ComplexNumber(real, imaginary);
    }

    public static ComplexNumber multiplication(ComplexNumber operand1, ComplexNumber operand2){
        double real = operand1.getReal() * operand2.getReal() - operand1.getImaginary() * operand2.getImaginary();
        double imaginary = operand1.getReal() * operand2.getImaginary() + operand1.getImaginary() * operand2.getReal();

        return  new ComplexNumber(real, imaginary);
    }

    public static ComplexNumber division(ComplexNumber operand1, ComplexNumber operand2){
        double real = operand1.getReal() * operand2.getReal() + operand1.getImaginary() * operand2.getImaginary();
        double imaginary = operand1.getReal() * operand2.getImaginary() - operand1.getImaginary() * operand2.getReal();
        double denominator = operand2.getReal() * operand2.getReal() + operand2.getImaginary() * operand2.getImaginary();

        return  new ComplexNumber(real / denominator, imaginary / denominator);
    }

    @Override
    @SuppressWarnings({"RedundantIfStatement"})
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o instanceof ComplexNumber) {
            ComplexNumber that = (ComplexNumber) o;
            if (!Objects.equals(real, that.real)) return false;
            if (!Objects.equals(imaginary, that.imaginary)) return false;
            return true;
        }
        return false;
    }

    @Override
    public int hashCode() {
        int result = 0;
        result = 31 * result + (real == null ? 0 : real.hashCode());
        result = 31 * result + (imaginary == null ? 0 : imaginary.hashCode());
        return result;
    }

    @Override
    public String toString() {
        return real + (imaginary > 0 ? " + " : " - ") + Math.abs(imaginary) + "i";
    }
}

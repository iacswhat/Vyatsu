package com.vyatsu.complexcalculator;

public interface TwoFunction<A, B, C> {
    A apply(B operand1, C operand2);
}

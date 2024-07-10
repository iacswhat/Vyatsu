package com.example.acchelper.entity.championship;

import com.example.acchelper.entity.Parsable;

import java.util.ArrayList;
import java.util.List;

public class Row implements Parsable {
    private Long id;

    private List<String> data = new ArrayList<>();
    private Chart chart;


    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public List<String> getData() {
        return data;
    }

    public void setData(List<String> data) {
        this.data = data;
    }

    public Chart getChart() {
        return chart;
    }

    public void setChart(Chart chart) {
        this.chart = chart;
    }
}
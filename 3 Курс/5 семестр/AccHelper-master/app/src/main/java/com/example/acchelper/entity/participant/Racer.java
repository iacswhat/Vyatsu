package com.example.acchelper.entity.participant;


import com.example.acchelper.entity.Parsable;
import com.example.acchelper.entity.championship.Chart;

public class Racer implements Parsable {
    private Long id;
    private String url;
    private String name;
    private String city;
    private String country;
    private Chart chart;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public Chart getChart() {
        return chart;
    }

    public void setChart(Chart chart) {
        this.chart = chart;
    }

}
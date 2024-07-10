package com.example.acchelper.entity.participant;

import com.example.acchelper.entity.Parsable;
import com.example.acchelper.entity.championship.Chart;

import java.util.LinkedHashSet;
import java.util.Set;

public class Team implements Parsable {
    private Long id;
    private String name;
    private Chart chart;
    private Set<String> racers = new LinkedHashSet<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Chart getChart() {
        return chart;
    }

    public void setChart(Chart chart) {
        this.chart = chart;
    }

    public Set<String> getRacers() {
        return racers;
    }

    public void setRacers(Set<String> racers) {
        this.racers = racers;
    }

}
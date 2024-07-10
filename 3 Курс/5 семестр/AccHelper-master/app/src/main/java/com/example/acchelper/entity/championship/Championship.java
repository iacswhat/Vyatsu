package com.example.acchelper.entity.championship;

import com.example.acchelper.entity.Parsable;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Championship implements Parsable {
    private Long id;
    private Integer internalId;
    private String name;
    private String status;
    private String simulator;
    private String organization;
    private String beginDate;
    private String endDate;
    private List<Chart> charts = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getInternalId() {
        return internalId;
    }

    public void setInternalId(Integer internalId) {
        this.internalId = internalId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSimulator() {
        return simulator;
    }

    public void setSimulator(String simulator) {
        this.simulator = simulator;
    }

    public String getOrganization() {
        return organization;
    }

    public void setOrganization(String organization) {
        this.organization = organization;
    }

    public String getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(String beginDate) {
        this.beginDate = beginDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public List<Chart> getCharts() {
        return charts;
    }

    public void setCharts(List<Chart> charts) {
        this.charts = charts;
    }
}
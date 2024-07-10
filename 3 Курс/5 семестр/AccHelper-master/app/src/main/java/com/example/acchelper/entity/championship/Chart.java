package com.example.acchelper.entity.championship;

import com.example.acchelper.entity.Parsable;
import com.example.acchelper.entity.participant.Racer;
import com.example.acchelper.entity.participant.Team;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.ArrayList;
import java.util.List;

public class Chart implements Parsable {
    private Long id;
    private String title;
    private String url;
    @JsonProperty("isTeam")
    private Boolean isTeam;
    private List<String> result = new ArrayList<>();
    private Championship championship;
    private List<Row> rows = new ArrayList<>();
    private List<Stage> stages = new ArrayList<>();
    private List<Racer> racers = new ArrayList<>();
    private List<Team> teams = new ArrayList<>();

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Boolean getIsTeam() {
        return isTeam;
    }

    public void setTeam(Boolean team) {
        isTeam = team;
    }

    public List<String> getResult() {
        return result;
    }

    public void setResult(List<String> result) {
        this.result = result;
    }

    public Championship getChampionship() {
        return championship;
    }

    public void setChampionship(Championship championship) {
        this.championship = championship;
    }

    public List<Row> getRows() {
        return rows;
    }

    public void setRows(List<Row> rows) {
        this.rows = rows;
    }

    public List<Stage> getStages() {
        return stages;
    }

    public void setStages(List<Stage> stages) {
        this.stages = stages;
    }

    public List<Racer> getRacers() {
        return racers;
    }

    public void setRacers(List<Racer> racers) {
        this.racers = racers;
    }

    public List<Team> getTeams() {
        return teams;
    }

    public void setTeams(List<Team> teams) {
        this.teams = teams;
    }
}
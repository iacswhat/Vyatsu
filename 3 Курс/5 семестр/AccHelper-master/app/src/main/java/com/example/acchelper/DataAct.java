package com.example.acchelper;

import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.HorizontalScrollView;
import android.widget.ScrollView;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.example.acchelper.entity.championship.Championship;
import com.example.acchelper.entity.championship.Chart;
import com.example.acchelper.entity.championship.Row;
import com.example.acchelper.entity.championship.Stage;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class DataAct extends AppCompatActivity {
    TextView textChart;
    TextView textChampionship;
    Spinner spinnerChampionship;
    Spinner spinnerChart;

    TableLayout table;
    List<Championship> championshipList = new ArrayList<>();

    String selectedChampionship;
    String selectedChart;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        AsyncTask.execute(() -> {
            final String url = "http://192.168.209.127:3000/championships/";
            RestTemplate restTemplate = new RestTemplate();
            List<Championship> championships = new ArrayList<>();
            try {
                for (int i = 1; i < 25; i++) {
                    Championship current = null;
                    restTemplate.getMessageConverters().add(new MappingJackson2HttpMessageConverter());
                    try {
                        current = restTemplate.getForEntity(url + i, Championship.class).getBody();
                    } catch (Exception e) {
                    }
                    if (current != null && current.getId() != 0) {
                        championships.add(current);
                    }
                }
            } catch (Exception e) {
                Championship championship = new Championship();
                championship.setName("null");
                Chart chart = new Chart();
                chart.setTitle("null");
                championship.getCharts().add(chart);
                championshipList.add(championship);
            }
            if (championships.size() != 0) {
                championshipList.addAll(championships);
                fillInSpinnerChampionship();
            }
        });

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_data);

        textChampionship = findViewById(R.id.textChampionship);
        textChart = findViewById(R.id.textChart);
        spinnerChampionship = findViewById(R.id.spinnerChampionship);
        spinnerChart = findViewById(R.id.spinnerChart);
        table = findViewById(R.id.table);


        textChampionship.setText("Выберите чемпионат:");
        textChart.setText("Выберите таблицу:");
        fillInSpinnerChampionship();
        spinnerChampionship.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parentView, View selectedItemView, int position, long id) {
                selectedChampionship = (String) parentView.getItemAtPosition(position);
                List<String> updatedChartNames = getChartNamesForChampionship(selectedChampionship);
                ArrayAdapter<String> updatedChartAdapter = new ArrayAdapter<>(DataAct.this, android.R.layout.simple_spinner_item, updatedChartNames);
                updatedChartAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
                spinnerChart.setAdapter(updatedChartAdapter);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parentView) {
                // Обработка случая, когда не выбран ни один чемпионат
            }
        });
        spinnerChart.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parentView, View selectedItemView, int position, long id) {
                selectedChart = (String) parentView.getItemAtPosition(position);
                updateTable(selectedChampionship, selectedChart);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parentView) {
            }
        });
    }

    private void fillInSpinnerChampionship() {
        runOnUiThread(() -> {
            List<String> championshipNames = new ArrayList<>();
            for (Championship championship : championshipList) {
                championshipNames.add(championship.getName());
            }
            ArrayAdapter<String> championshipAdapter = new ArrayAdapter<>(this, android.R.layout.simple_spinner_item, championshipNames);
            championshipAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            spinnerChampionship.setAdapter(championshipAdapter);
        });
    }


    private List<String> getChartNamesForChampionship(String selectedChampionship) {
        List<String> chartNames = new ArrayList<>();
        for (Championship championship : championshipList) {
            if (Objects.equals(championship.getName(), selectedChampionship)) {
                for (Chart chart : championship.getCharts()) {
                    chartNames.add(chart.getTitle());
                }
                break;
            }
        }
        return chartNames;
    }

    private void updateTable(String selectedChampionship, String selectedChart) {
        table.removeAllViews();

        Chart currentChart = null;
        for (Championship championship : championshipList) {
            if (Objects.equals(championship.getName(), selectedChampionship)) {
                for (Chart chart : championship.getCharts()) {
                    if (Objects.equals(chart.getTitle(), selectedChart)) {
                        currentChart = chart;
                        break;
                    }
                }
            }
        }

        if (currentChart != null) {
            TableRow headerRow = new TableRow(this);
            //Next
            int i = 0;
            TextView textViewTable = new TextView(this);
            textViewTable.setText("Таблица");
            i++;
            textViewTable.setPadding(3, 3, 3, 3);
            headerRow.addView(textViewTable);
            //Next
            for (Stage stage : currentChart.getStages()) {
                TextView textViewStage = new TextView(this);
                textViewStage.setText("S" + i);
                if (i % 2 == 1)
                    textViewStage.setBackgroundColor(Color.GRAY);
                i++;
                textViewStage.setPadding(3, 3, 3, 3);
                headerRow.addView(textViewStage);
            }
            //Next
            TextView textViewFinalResult = new TextView(this);
            textViewFinalResult.setText("Результаты");
            if (i % 2 == 1)
                textViewFinalResult.setBackgroundColor(Color.GRAY);
            i++;
            textViewFinalResult.setPadding(3, 3, 3, 3);
            headerRow.addView(textViewFinalResult);
            if (currentChart.getStages().size() % 2 == 0)
                i++;
            //Next
            table.addView(headerRow);
            for (int j = 0; j < currentChart.getResult().size(); j++) {
                TableRow row = new TableRow(this);
                //Next
                String name;
                if (currentChart.getIsTeam()) {
                    name = currentChart.getTeams().get(j).getName();
                } else {
                    name = currentChart.getRacers().get(j).getName();
                }
                TextView textViewParticipant = new TextView(this);
                textViewParticipant.setText(name);
                textViewParticipant.setPadding(3, 3, 3, 3);
                if (i % 2 == 1)
                    textViewParticipant.setBackgroundColor(Color.GRAY);
                i++;
                row.addView(textViewParticipant);
                //Next
                for (String s : currentChart.getRows().get(j).getData()) {
                    TextView textViewData = new TextView(this);
                    textViewData.setText(s);
                    if (i % 2 == 1)
                        textViewData.setBackgroundColor(Color.GRAY);
                    i++;
                    textViewData.setPadding(3, 3, 3, 3);
                    row.addView(textViewData);
                }
                //Next
                TextView textViewResult = new TextView(this);
                textViewResult.setText(currentChart.getResult().get(j));
                if (i % 2 == 1)
                    textViewResult.setBackgroundColor(Color.GRAY);
                i++;
                textViewResult.setPadding(3, 3, 3, 3);
                row.addView(textViewResult);
                if (currentChart.getStages().size() % 2 == 0)
                    i++;
                //Next
                table.addView(row);
            }
        }
    }
}

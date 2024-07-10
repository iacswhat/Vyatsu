package com.example.acchelper;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.RadioGroup;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

import com.example.acchelper.entity.championship.Championship;

import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

public class SecAct extends AppCompatActivity {


    private TextView questionTextView;
    private RadioGroup answerRadioGroup;
    private Button nextButton;
    private Button generateAdviceButton;
    private TextView adviceTextView;


    private int currentQuestionIndex = 0;
    private String[] questions = {
            "Ощущаете ли вы недостаточную поворачиваемость при входе в поворот?",
            "Ощущаете ли вы избыточную поворачиваемость при входе в поворот?",
    };

    private boolean[][] userAnswers;
    private String[] adviceOptions = {
            "Уменьшить дорожный просвет спереди на 1 мм.\n" +
                    "Уменьшить заднее антикрыло на 1 пункт.\n" +
                    "Увеличить задний дорожный просвет на 2 мм.\n" +
                    "Увеличить свободный ход передней подвески до упора в ограничители на 1 пункт.\n" +
                    "Уменьшить жесткость ограничителей хода передней подвески на 1 пункт.\n" +
                    "Уменьшить баланс тормозов (сместить в сторону задней оси).",
            "Увеличить заднее антикрыло на 1 пункт.\n" +
                    "Увеличить дорожный просвет спереди на 1 мм.\n" +
                    "Уменьшить задний дорожный просвет на 2 мм.\n" +
                    "Уменьшить свободный ход передней подвески до упора в ограничители на 1 пункт.\n" +
                    "Увеличить жесткость ограничителей хода передней подвески на 1 пункт.\n" +
                    "Увеличить баланс тормозов (сместить в сторону передней оси).",
    };

    private int selected1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sec);


        questionTextView = findViewById(R.id.questionTextView);
        answerRadioGroup = findViewById(R.id.answerRadioGroup);
        nextButton = findViewById(R.id.nextButton);
        generateAdviceButton = findViewById(R.id.generateAdviceButton);
        adviceTextView = findViewById(R.id.adviceTextView);

        userAnswers = new boolean[questions.length][2];

        nextButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                int selectedId = answerRadioGroup.getCheckedRadioButtonId();
                if (selectedId != -1) {
                    RadioButton selectedRadioButton = findViewById(selectedId);
                    boolean answer = selectedRadioButton.getId() == R.id.yesRadioButton;
                    userAnswers[currentQuestionIndex][0] = answer;
                    userAnswers[currentQuestionIndex][1] = !answer; // Обратный ответ
                    answerRadioGroup.clearCheck();
                    currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
                    updateQuestion();
                }
            }
        });

        generateAdviceButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String advice = generateAdvice();
                adviceTextView.setText("Совет: " + advice);
            }
        });

        updateQuestion();


    }

    private void updateQuestion() {
        questionTextView.setText(questions[currentQuestionIndex]);
    }

    private String generateAdvice() {
        return adviceOptions[currentQuestionIndex];
    }
}
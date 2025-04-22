/* TO DO
-make settings page look nice
XX-clean up note display
X-write logic for dense note stacking
X-add back button (how?)
-Xadd autoupdating slider   (how??)
-add accidentals (and maybe keys?)
X-add ledger lines
-sound??????
-make code cleaner
-X immediate update canvas on page
-Xmake intro page auto update
-maybe have range be the deciding factor for note count if range < note count. it is currently vice vera
-key signatures (slider from -8 to +8 that determines the amount of flats or sharps)
-make accidentals look much better
-ledger lines on offset notes do not line up perfectly

*****For main Page*****
-Improve the general look (how??)
-replace all the accidental choices with Accidentals dropdown box with checkboxes
- make a back button on the canvas
*/


package com.example.chordsightreadingredo;

import static com.google.android.material.slider.Slider.*;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import android.annotation.SuppressLint;

import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ArrayAdapter;
import android.widget.Button;
import java.util.LinkedHashMap;
import android.content.Intent;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;

import com.google.android.material.slider.Slider;


public class MainActivity extends AppCompatActivity {

    int noteCountNum = 2;
    int rangeNum = 1;
    int lowestNoteNum = 1;
    MyCanvas grappu;
    TextView noteRangeView;

    ////////

    ////////





    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);

        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        getSupportActionBar().show();


        setContentView(R.layout.activity_main);
        Intent intent = new Intent(MainActivity.this, pageTwo.class);


        grappu  = (MyCanvas)findViewById(R.id.TestCanvas);
        grappu.drawMax(noteCountNum,lowestNoteNum,rangeNum);



        LinkedHashMap<Integer, String> PianoNotesMap = new LinkedHashMap<Integer, String>() {{
            put(1, "A0");
            put(2, "B0");
            put(3, "C1");
            put(4, "D1");
            put(5, "E1");
            put(6, "F1");
            put(7, "G1");
            put(8, "A1");
            put(9, "B1");
            put(10, "C2");
            put(11, "D2");
            put(12, "E2");
            put(13, "F2");
            put(14, "G2");
            put(15, "A2");
            put(16, "B2");
            put(17, "C3");
            put(18, "D3");
            put(19, "E3");
            put(20, "F3");
            put(21, "G3");
            put(22, "A3");
            put(23, "B3");
            put(24, "C4");
            put(25, "D4");
            put(26, "E4");
            put(27, "F4");
            put(28, "G4");
            put(29, "A4");
            put(30, "B4");
            put(31, "C5");
            put(32, "D5");
            put(33, "E5");
            put(34, "F5");
            put(35, "G5");
            put(36, "A5");
            put(37, "B5");
            put(38, "C6");
            put(39, "D6");
            put(40, "E6");
            put(41, "F6");
            put(42, "G6");
            put(43, "A6");
            put(44, "B6");
            put(45, "C7");
            put(46, "D7");
            put(47, "E7");
            put(48, "F7");
            put(49, "G7");
            put(50, "A7");
            put(51, "B7");
            put(52, "C8");
        }};

        {//event  Listeners
            final OnSliderTouchListener difficultyListener = //these can probably be combined
                    new OnSliderTouchListener() {
                        @SuppressLint("RestrictedApi")
                        @Override
                        public void onStartTrackingTouch(@NonNull Slider noteCount) {


                        }

                        @SuppressLint("RestrictedApi")
                        @Override
                        public void onStopTrackingTouch(Slider noteCount) {

                            noteCountNum = (int) noteCount.getValue();
                            intent.putExtra("noteCount", noteCountNum);
                            grappu.drawMax(noteCountNum,lowestNoteNum,rangeNum);
                        }
                    };
            final OnSliderTouchListener rangeListener =
                    new OnSliderTouchListener() {
                        @SuppressLint("RestrictedApi")
                        @Override
                        public void onStartTrackingTouch(@NonNull Slider Range) {
                        }

                        @SuppressLint("RestrictedApi")
                        @Override
                        public void onStopTrackingTouch(Slider Range) {
                            rangeNum = (int) Range.getValue();
                            intent.putExtra("range", rangeNum);
                            noteRangeView.setText(PianoNotesMap.get(lowestNoteNum) + "-" + PianoNotesMap.get(Math.min(lowestNoteNum + rangeNum, 52)));
                            grappu.drawMax(noteCountNum,lowestNoteNum,rangeNum);

                        }
                    };
            final OnSliderTouchListener lowestNoteListener =
                    new OnSliderTouchListener() {
                        @SuppressLint("RestrictedApi")
                        @Override
                        public void onStartTrackingTouch(@NonNull Slider Lowest) {

                        }

                        @SuppressLint("RestrictedApi")
                        @Override
                        public void onStopTrackingTouch(Slider Lowest) {
                            lowestNoteNum = (int) Lowest.getValue();
                            intent.putExtra("lowest", lowestNoteNum);
                            noteRangeView.setText(PianoNotesMap.get(lowestNoteNum) + "-" + PianoNotesMap.get(Math.min(lowestNoteNum + rangeNum, 52)));
                            grappu.drawMax(noteCountNum,lowestNoteNum,rangeNum);
                        }
                    };

            Switch trebleSwitch = (Switch) findViewById(R.id.trebleclefswitch);
            Switch bassSwitch = (Switch) findViewById(R.id.bassclefswitch);
            Switch sharpSwitch = (Switch) findViewById(R.id.sharpSwitch);
            Switch flatSwitch = (Switch) findViewById(R.id.flatSwitch);
            Switch doublesharpSwitch = (Switch) findViewById(R.id.doubleSharp);
            Switch doubleflatSwitch = (Switch) findViewById(R.id.doubleflat);

            Switch showSettings = (Switch) findViewById(R.id.ShowSettings);

            trebleSwitch.setVisibility(View.GONE);
            bassSwitch.setVisibility(View.GONE);
            doubleflatSwitch.setVisibility(View.GONE);
            doublesharpSwitch.setVisibility(View.GONE);
            sharpSwitch.setVisibility(View.GONE);
            flatSwitch.setVisibility((View.GONE));

            showSettings.setChecked(false);

            showSettings.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(showSettings.isChecked()){
                        trebleSwitch.setVisibility(View.VISIBLE);
                        bassSwitch.setVisibility(View.VISIBLE);
                        doubleflatSwitch.setVisibility(View.VISIBLE);
                        doublesharpSwitch.setVisibility(View.VISIBLE);
                        sharpSwitch.setVisibility(View.VISIBLE);
                        flatSwitch.setVisibility((View.VISIBLE));
                    }else{
                        trebleSwitch.setVisibility(View.GONE);
                        bassSwitch.setVisibility(View.GONE);
                        doubleflatSwitch.setVisibility(View.GONE);
                        doublesharpSwitch.setVisibility(View.GONE);
                        sharpSwitch.setVisibility(View.GONE);
                        flatSwitch.setVisibility((View.GONE));
                    }

                }
            });




            Button TestButton = (Button) findViewById(R.id.TestButton);
            TestButton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    // grappu.remake(noteCountNum,rangeNum,lowestNoteNum);

                        getSupportActionBar().hide();

                    System.out.println("Qtest1");
                    //setContentView(grappu);
                    intent.putExtra("trebleClicked", trebleSwitch.isChecked());
                    intent.putExtra("bassClicked", bassSwitch.isChecked());
                    intent.putExtra("sharpChecked", sharpSwitch.isChecked());
                    intent.putExtra("flatChecked", flatSwitch.isChecked());
                    intent.putExtra("doublesharpChecked", doublesharpSwitch.isChecked());
                    intent.putExtra("doubleflatChecked", doubleflatSwitch.isChecked());

                    startActivity(intent); //this will make it better

                }
            });


            noteRangeView = (TextView) findViewById(R.id.NoteRange);
            Slider noteCount = findViewById(R.id.DifficultySlider);
            noteCount.addOnSliderTouchListener(difficultyListener);
            Slider Range = findViewById(R.id.RangeSlider);
            Range.addOnSliderTouchListener(rangeListener);
            Slider Lowest = findViewById(R.id.LowestNoteSlider);
            Lowest.addOnSliderTouchListener(lowestNoteListener);

            noteCount.addOnChangeListener(new OnChangeListener() {
                @SuppressLint("RestrictedApi")
                @Override
                public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
                    grappu.drawMax((int) noteCount.getValue(),(int)Lowest.getValue(),(int) Range.getValue());
                    intent.putExtra("lowest", lowestNoteNum);
                    intent.putExtra("range", rangeNum);
                    intent.putExtra("noteCount", noteCountNum);



                }
            });






            Lowest.addOnChangeListener(new OnChangeListener() {
                @SuppressLint("RestrictedApi")
                @Override
                public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
                    grappu.drawMax((int) noteCountNum,(int)Lowest.getValue(),(int) Range.getValue());
                    intent.putExtra("lowest", lowestNoteNum);
                    intent.putExtra("range", rangeNum);
                    intent.putExtra("noteCount", noteCountNum);
                    noteRangeView.setText(PianoNotesMap.get((int)Lowest.getValue()) + "-" + PianoNotesMap.get(Math.min((int)Lowest.getValue() + (int) Range.getValue(), 52)));



                }
            });

            Range.addOnChangeListener(new OnChangeListener() {
                @SuppressLint("RestrictedApi")
                @Override
                public void onValueChange(@NonNull Slider slider, float value, boolean fromUser) {
                    grappu.drawMax(noteCountNum,(int)Lowest.getValue(),(int) Range.getValue());
                    intent.putExtra("lowest", lowestNoteNum);
                    intent.putExtra("range", rangeNum);
                    intent.putExtra("noteCount", noteCountNum);
                    noteRangeView.setText(PianoNotesMap.get((int)Lowest.getValue()) + "-" + PianoNotesMap.get(Math.min((int)Lowest.getValue() + (int) Range.getValue(), 52)));
                }
            });
        }
    }
}


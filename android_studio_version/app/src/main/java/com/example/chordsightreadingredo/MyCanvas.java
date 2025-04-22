package com.example.chordsightreadingredo;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.View;

import androidx.annotation.Nullable;

import java.util.Arrays;

//699 lines pre-cleanup
// X lines post-cleanup

/*
Functions to check:d
X - public int[] returnOffsetList(int[] notes)
  - public int[] returnAccidentalsOffset(int[] acc,int[] offset,int [] notes)
X - public boolean isCentered(int a,int index)
X - public void setmAccidentalImage()
X - public MyCanvas()
X - public MyCanvas(Context context)
  - public MyCanvas(Context context, int n, int r, int l, boolean t , boolean b,boolean[] accidentalKey)
  - public MyCanvas(Context context, AttributeSet attributeSet)
  - public void drawMax(int l, int r)
  - public void remake(int n, int r, int l,boolean t , boolean b,boolean[] acc)
  - public int[] findExtrema(int[] numbers)
X - public boolean ifMiddleC(int[] numbers, int Center)
  - public int[] returnAccidentals(int n,boolean[] acc)
  - protected void onDraw(Canvas canvas)
        -Improve Positioning of notes and ledgers, doesnt work on all devices correctly
         -tie everything to distance from parent (phone)
 */
public class MyCanvas extends View {
    MainActivity main = new MainActivity();
    pageTwo pg2 = new pageTwo();
    int[] offsetList;
    public int[] returnOffsetList(int[] notes){ //Finds any adjacent notes that need to be offset
        offsetList = new int[notes.length];
        offsetList[0] = 0; //never offset bottom note
        for(int i = 1; i < notes.length;i++){
            if(notes[i] - notes[i-1] ==1 && offsetList[i-1] !=1){//if notes are touching and isnt already offset
                offsetList[i] = 1;
            }else{
                offsetList[i] = 0;
            }
        }
        return(offsetList);
        //at the end, if there are more offest notes than not offset notes, flip them
    }

    public int[] returnAccidentalsOffset(int[] acc,int[] offset,int [] notes){//offsets the accidentals tied to each note
        int [] array = new int[acc.length];
        int len = notes.length;
        double[][] safeBound = {{1.3,2.4},{-1.1,2.2},{0,0},{-1.6,1.6},{-1,1}}; //{lower,higher , width} (width will be potentially added idk yet)
                    //^ use the actual size of the notes to be more specific with the safebound
        System.out.println("Qtest33Notes:"+ Arrays.toString(newNoteList));
        System.out.println("Qtest33acc:"+ Arrays.toString(acc));

        //next 17ish lines weed out the naturals, can add an if statement later on to toggle this if naturals are to be shown.
        int NattyCount = 0;
        for (int i = 0; i < len; i++) {
            if(acc[i]==0){
                NattyCount+=1;
            }
        }
        int newlen = len - NattyCount;
        int[] cleanAccArray = new int[newlen];
        int[] cleanNoteArray = new int[newlen];
        int k = 0;
        for (int i = 0; i < len; i++) {
            if(acc[i]!=0){
                cleanAccArray[k] = acc[i];
                cleanNoteArray[k] = notes[i];
                k+=1;
            }
        }
        System.out.println("Qtest33:" + Arrays.toString(cleanAccArray) + Arrays.toString(cleanNoteArray));
        //

        for(int i = 0;i<newlen;i++){
            boolean bottomTouching = false;
            boolean topTouching = false;
            double accUpperBound = notes[i] + safeBound[acc[i]+2][1];
            double accLowerBound = notes[i] + safeBound[acc[i]+2][0];
            if(i<newlen-1){//Ignores the top note
                for(int j = i+1;j<newlen;j++){//Check if the top is touching
                    if(accUpperBound > cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][0]){//if The top of the current acc is above the bottom of the next acc (touching)
                        topTouching = true;
                    }
                }
            }
            if(i>0){//Ignores the bottom note
                for(int j = newlen-1;j> i;j--){//Check if the bottom is touching
                    if(accLowerBound < cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][1]){//if The bottom of the current acc is below the top of the next acc (touching)
                        topTouching = true;
                    }
                }
            }
            if(!bottomTouching && !topTouching){

            }
            System.out.print("Qtest33:"+bottomTouching+topTouching);


            //for each non natural accidental
            //check above accidental to see if it is clear
            //check below accidental to see if it is clear
            //it it is completely clear, give it a zero offset and remove it from the list
        }





        for(int i = 0;i<len;i++){
            int j = i;
        }
/*
        for(int i = 0;i<newlen;i++) { //for each accidental
            boolean LowTouching = false;
            boolean HighTouching = false;
            double accUpperBound = notes[i] + safeBound[acc[i]+2][1];
            double accLowerBound = notes[i] + safeBound[acc[i]+2][0];
            if(i<newlen-1){ //if not the top note
                for(int j = i+1;j<newlen;j++){//check every accidental above the current one
                    if(accUpperBound < cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][0]){ //if accupperbound < the next acclowerbound
                        HighTouching = false;

                    }else{
                        HighTouching = true;
                        break; //if any accidentals above the original are touching
                    }
                }
            }
            if(i>0){ //if not the bottom note
                for(int j = 1;j<i;j++){//check every accidental below the current one
                    if(accLowerBound > cleanNoteArray[j] + safeBound[cleanAccArray[j]+2][1]){ //if acclowerbound > the previous accupperbound
                        LowTouching = false;
                    }else{
                        LowTouching = true;
                        break; //if any accidentals above the original are touching
                    }
                }
            }

            if(!LowTouching && !HighTouching){
                array[i] = 0;
                System.out.println("Qtest33:"+ cleanNoteArray[i] + ";"+LowTouching + HighTouching);
            }else{
                array[i] = -1;
                System.out.println("Qtest33:"+ cleanNoteArray[i]  + ";"+LowTouching + HighTouching);
            }
        }*/
        return(array);
    }

    public boolean isCentered(int a,int index) {
        for (int item : newNoteList) {
            if (a-item == 1 && offsetList[index-1] != 1 ) {
                return (false);
            }
        }
        return (true);
    }


    int[] newNoteList;

    //Drawables
    private Drawable wholeNoteImage;
    private Drawable staff;
    private Drawable staffpng;
    private Drawable back;
    private Drawable line;
    private Drawable trebleClef;
    private Drawable bassClef;
    private Drawable HighBracketLine;
    private Drawable LowBracketLine;
    private Drawable VerticalBracketLine;

    Drawable[] extendedLedgers;
    Drawable[] mCustomImage;
    Drawable[] mAccidentalImage;

    int[] myImageList;
    int[] mAccidentals;
    int nCn;
    int rN;
    int lN;
    int noteCount;
    boolean trebleChecked;
    boolean bassChecked;
    boolean drawingMax = false;

    @Override
    public void setOnClickListener(@Nullable OnClickListener l) {
        super.setOnClickListener(l);
      //  l.onClick();

        }

    public void setmAccidentalImage(){
        for(int i=0;i<newNoteList.length;i++) {
            if(mAccidentals[i]==-2){
                mAccidentalImage[i] = getResources().getDrawable(R.drawable.musicdoubleflat);
            }else if(mAccidentals[i]==-1){
                mAccidentalImage[i] = getResources().getDrawable(R.drawable.musicflat);
            }else if(mAccidentals[i]==1){
                mAccidentalImage[i] = getResources().getDrawable(R.drawable.musicsharp);
            }else if(mAccidentals[i]==2){
                mAccidentalImage[i] = getResources().getDrawable(R.drawable.musicdoublesharp);
            }else if(mAccidentals[i]==0){//doing natural notes last
                mAccidentalImage[i] = getResources().getDrawable(R.drawable.musicnatural); //for now it is always going to show natural or not
            }
        }
    }

    //MyCanvas//-------------------------------------------------------------------------------------------------------

    public MyCanvas(){
        super(null,null);
        drawingMax = false;
    }

    public MyCanvas(Context context){
        super(context);
        drawingMax = false;
    }

    public MyCanvas(Context context, int n, int r, int l, boolean t , boolean b, boolean[] accidentalKey) {
        super(context); //figure out what this context means
        nCn = n;
        rN = r;
        lN = l;
        trebleChecked = t;
        bassChecked = b;
        drawingMax = false;

        newNoteList = (pg2.returnArray(nCn,rN,lN));

        mCustomImage = new Drawable[newNoteList.length]; //newNoteList.length
        myImageList = new int[newNoteList.length]; //newNoteList.length

        for(int i=0;i<newNoteList.length;i++) {//makes a list of whole note images
            mCustomImage[i] = context.getResources().getDrawable(R.drawable.wholenote);
        }

        staff = context.getResources().getDrawable(R.drawable.staff);

        mAccidentals = returnAccidentals(nCn,accidentalKey);

        mAccidentalImage = new Drawable[mAccidentals.length];
        setmAccidentalImage();
        System.out.println("Qtest20:"+Arrays.toString(mAccidentals));
        //add logic to naturalize notes that are natural, but the same note is elsewhere
    }

    public MyCanvas(Context context, AttributeSet attributeSet){
        super(context,attributeSet);
        int n = 5;
        int range = 5;
        int lowest = 20;
        newNoteList = pg2.returnArray(n,range,lowest);
        System.out.println();
        trebleChecked = true;
        bassChecked = true;
        drawingMax = false;
        mCustomImage = new Drawable[n]; //newNoteList.length
        myImageList = new int[n]; //newNoteList.length
        boolean[] frop = new boolean[] {false,false,false,false};
        mAccidentals = returnAccidentals(n,frop);
        mAccidentalImage = new Drawable[mAccidentals.length];
        setmAccidentalImage();
        for(int i=0;i<newNoteList.length;i++){
            myImageList[i] = R.drawable.wholenote;
        }
        for(int i=0;i<newNoteList.length;i++) {//work on this
            mCustomImage[i] = context.getResources().getDrawable(R.drawable.wholenote);
        }
        staff = context.getResources().getDrawable(R.drawable.staff);
       //setBackground(context.getResources().getDrawable(R.drawable.staff));
    }

    public void drawMax(int n, int l, int r){ //for the settings/home page draws the canvas that only has the min and max note
        drawingMax = true;
        noteCount = n;
        if(l!=52) {
            newNoteList =  new int[] {l,Math.min(l+r,52)};
            mCustomImage = new Drawable[2]; //newNoteList.length
            myImageList = new int[2]; //newNoteList.length
            myImageList[0] = R.drawable.wholenote;
            myImageList[1] = R.drawable.wholenote;
            mCustomImage[0] = this.getResources().getDrawable(R.drawable.wholenote);
            mCustomImage[1] = this.getResources().getDrawable(R.drawable.wholenote);

        }else{
            newNoteList =  new int[] {52};
            mCustomImage = new Drawable[1]; //newNoteList.length
            myImageList = new int[1]; //newNoteList.length
            mCustomImage[0] = this.getResources().getDrawable(R.drawable.wholenote);
            myImageList[0] = R.drawable.wholenote;
        }
        staff = this.getResources().getDrawable(R.drawable.staff);
        invalidate();
    }

    public void remake(int n, int r, int l,boolean t , boolean b,boolean[] acc){
        newNoteList = pg2.returnArray(n,r,l);
        trebleChecked = t;
        bassChecked = b;
        mCustomImage = new Drawable[n]; //newNoteList.length
        myImageList = new int[n]; //newNoteList.length
        mAccidentals = returnAccidentals(n,acc);
        setmAccidentalImage();
        for(int i=0;i<newNoteList.length;i++){
            myImageList[i] = R.drawable.wholenote;
        }
        for(int i=0;i<newNoteList.length;i++) {//work on this
            mCustomImage[i] = this.getResources().getDrawable(R.drawable.wholenote);
        }
        staff = this.getResources().getDrawable(R.drawable.staff); //staff is no longer needed, delete all of these
      //  setBackground(this.getResources().getDrawable(R.drawable.staff));
      //  returnAccidentals(n,acc);--------------------
        invalidate();
    }

    public int[] findExtrema(int[] numbers){
       int max = -1000; //extremely low
        int min = 1000; //extremely high
       for(int i=0;i<numbers.length;i++){
          if(numbers[i] > max){
              max = numbers[i];
          }
          if(numbers[i] < min){
              min = numbers[i];
          }
       }
       return(new int[] {min , max});
    }

    public boolean ifMiddleC(int[] numbers, int Center){ //draws ledger line if middle C is one of the notes
        for(int item : numbers) {
            if(item == Center){
                return(true);
            }
        }
       return(false);
    }

    public int[] returnAccidentals(int n,boolean[] acc){
       int[] allowedList = new int[5]; //5 possible accidentals
       for(int i = 0; i<acc.length;i++){
           if(acc[i]){
               allowedList[i] = i-2;//-2 is regarded as double flat
           }else{
               allowedList[i] = 3; // if there is a 3 in the array, it will be ignored
           }
       }
       int[] accidentals = new int[n];
       for(int i = 0;i<n;i++){
           int j = 3;
           while(j==3){ //in theory removes the threes
               j = allowedList[(int)(5*Math.random())];
           }
               accidentals[i] = j;
       }
       return(accidentals);
    }


    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int[] p = returnOffsetList(newNoteList); // either -1, 0, or 1
        //  System.out.print("Qtest99:");
        //  for(int num: p){
        //      System.out.print(num + ",");
        // }
        boolean bass = false;
        boolean treble = true;
        int noteCenter = 30;
        int width = getWidth();
        int height = getHeight();
        System.out.println("Qtest44:" + height);
        int noteX = (int) (width / 1.5);
        int lineHeight = height / 450;
        //add if statement to test and see if one or two staffs are necessary
        //currently only going to have 1 staff
        int noteHeight = (int) (.03 * height);
        if(noteHeight%2==1){ //removes rounding errors if noteheight is odd
            noteHeight +=1;
        }
        int noteWidth = (int) (noteHeight * 1.6);
        int ledgerExtWidth = 30;
        int Yoffset = noteHeight / 2;
        Drawable[] lines = new Drawable[5];

        ////////////////////////////////
        int highLedger = 35;
        int lowLedger = 25;
        int offset = 3;
        //everything within these comment lines must be reworked once multiple staffs are implemented to accommodate for more lines and whatnot
        trebleClef = getResources().getDrawable(R.drawable.trebleclef);
        bassClef = getResources().getDrawable(R.drawable.bassclef);
        if (drawingMax) {
            offset = 6;
            highLedger = 35;
            lowLedger = 13;
            noteCenter = 24;
            ledgerExtWidth = 20;
            lineHeight = height / 800;
            trebleClef.setBounds(10, height / 2 - (int) (6.5 * noteHeight), (int) (0.6 * (7.5 * noteHeight)) + 10, height / 2 + (1 * noteHeight));
            bassClef.setBounds(30, height / 2 - (int) (-1 * noteHeight), (int) (0.86 * (3.3 * noteHeight)) + 30, height / 2 + (int) (4.5 * noteHeight));
            trebleClef.draw(canvas);
            bassClef.draw(canvas);
            for (int i = 0; i < 5; i++) { //work on this
                lines = new Drawable[10];
                //draws singular staff at the center of the screen
                int k = i + 1;
                lines[i] = getResources().getDrawable(R.drawable.blackline3);
                lines[9 - i] = getResources().getDrawable(R.drawable.blackline3);
                lines[i].setBounds(25, height / 2 - lineHeight - (6 * noteHeight) + (k * noteHeight), width - 25, height / 2 + lineHeight - (6 * noteHeight) + (k * noteHeight));
                lines[9 - i].setBounds(25, height / 2 - lineHeight + (k * noteHeight), width - 25, height / 2 + lineHeight + (k * noteHeight));

                lines[i].draw(canvas);
                lines[9 - i].draw(canvas);
            }
            if (ifMiddleC(newNoteList, noteCenter)) {
                Drawable centerLedger = getResources().getDrawable(R.drawable.blackline3);
                centerLedger.setBounds(noteX - noteWidth / 2 - ledgerExtWidth, height / 2 - lineHeight, noteX + noteWidth / 2 + ledgerExtWidth, height / 2 + lineHeight);
                centerLedger.draw(canvas);
            }
            //draw bracket


        }
        else if (trebleChecked && bassChecked) {

            offset = 6; //consider replacing all sixes and threes with offset
            highLedger = 35;
            lowLedger = 13;
            noteCenter = 24;
            ledgerExtWidth = 20;
            lineHeight = height / 800;
            for (int i = 0; i < 5; i++) { //work on this
                lines = new Drawable[10];
                //draws singular staff at the center of the screen
                int k = i + 1;
                lines[i] = getResources().getDrawable(R.drawable.blackline3);
                lines[9 - i] = getResources().getDrawable(R.drawable.blackline3);
                lines[i].setBounds(25, height / 2 - lineHeight - (6 * noteHeight) + (k * noteHeight), width - 25, height / 2 + lineHeight - (6 * noteHeight) + (k * noteHeight));
                lines[9 - i].setBounds(25, height / 2 - lineHeight + (k * noteHeight), width - 25, height / 2 + lineHeight + (k * noteHeight));

                lines[i].draw(canvas);
                lines[9 - i].draw(canvas);
            }

            if (ifMiddleC(newNoteList, noteCenter)) {
                Drawable centerLedger = getResources().getDrawable(R.drawable.blackline3);
                centerLedger.setBounds(noteX - noteWidth / 2 - ledgerExtWidth, height / 2 - lineHeight, noteX + noteWidth / 2 + ledgerExtWidth, height / 2 + lineHeight);
                centerLedger.draw(canvas);
            }
            trebleClef.setBounds(-30, height / 2 - (int) (6.5 * noteHeight), (int) (0.6 * (7.5 * noteHeight)) - 30, height / 2 + (1 * noteHeight));
            bassClef.setBounds(30, height / 2 - (int) (-1 * noteHeight), (int) (0.86 * (3.3 * noteHeight)) + 30, height / 2 + (int) (4.5 * noteHeight));

            trebleClef.draw(canvas);
            bassClef.draw(canvas);


        }
        else {
            noteHeight = (int) (.05 * height);
            Yoffset = noteHeight / 2;
            noteWidth = (int) (noteHeight * 1.6);
            noteX = (int) (width / 1.5);
            for (int i = 0; i < 5; i++) {
                //draws singular staff at the center of the screen
                int k = i + 1;
                lines[i] = getResources().getDrawable(R.drawable.blackline3);
                lines[i].setBounds(25, height / 2 - lineHeight - (3 * noteHeight) + (k * noteHeight), width - 25, height / 2 + lineHeight - (3 * noteHeight) + (k * noteHeight));
                lines[i].draw(canvas);
            }
            if (trebleChecked) {
                offset = 3;
                highLedger = 35;
                lowLedger = 25;
                noteCenter = 30;
                ledgerExtWidth = 30;
                trebleClef.setBounds(-100, height / 2 - (int) (3.5 * noteHeight), (int) (0.6 * (7.5 * noteHeight)) - 100, height / 2 + (4 * noteHeight));
                trebleClef.draw(canvas);
            }
            if (bassChecked) {
                offset = 3;
                highLedger = 23;
                lowLedger = 13;
                noteCenter = 18;
                ledgerExtWidth = 30;
                bassClef.setBounds(60, height / 2 - (int) (2 * noteHeight), (int) (0.86 * (3.7 * noteHeight)), height / 2 + (int) (1.5 * noteHeight));
                bassClef.draw(canvas);
            }
        }

        if (findExtrema(newNoteList)[1] > highLedger) {
            int distance = Math.abs(findExtrema(newNoteList)[1] - highLedger);
            int lineCount = Math.abs((1 + distance - (findExtrema(newNoteList)[1] % 2)) / 2); //the '1+' at the beginning combats an offbyone error
            Drawable[] HighLedgerLines = new Drawable[lineCount];
            for (int i = 0; i < lineCount; i++) {
                HighLedgerLines[i] = getResources().getDrawable(R.drawable.blackline3);
                HighLedgerLines[i].setBounds(noteX - noteWidth / 2 - ledgerExtWidth, height / 2 - lineHeight - ((offset + i) * noteHeight), noteX + noteWidth / 2 + ledgerExtWidth, height / 2 + lineHeight - ((offset + i) * noteHeight));
                HighLedgerLines[i].draw(canvas);
            }
        }
        if (findExtrema(newNoteList)[0] < lowLedger) {
            int distance = Math.abs(findExtrema(newNoteList)[0] - lowLedger);
            int lineCount = Math.abs((distance - (findExtrema(newNoteList)[0] % 2)) / 2) + 1;
            Drawable[] LowLedgerLines = new Drawable[lineCount];
            for (int i = 0; i < lineCount; i++) {
                LowLedgerLines[i] = getResources().getDrawable(R.drawable.blackline3);
                LowLedgerLines[i].setBounds(noteX - noteWidth / 2 - ledgerExtWidth, height / 2 - lineHeight + ((offset + i) * noteHeight), noteX + noteWidth / 2 + ledgerExtWidth, height / 2 + lineHeight + ((offset + i) * noteHeight));
                LowLedgerLines[i].draw(canvas);
            }
        }

        int sum = 0;
        for (int i = 0; i < p.length; i++) {
            sum += p[i];
        }
        extendedLedgers = new Drawable[sum];
        //find extended ledgers
        for (int i = 0; i < newNoteList.length; i++) {
            int count = 0;
            int num = newNoteList[i];
            int r = 0;
            if (p[i] == 1) {
                int LedgNum = num;
                if (num > highLedger || num < lowLedger || num == 24) {
                    if (num > highLedger) {
                        LedgNum = num - num % 2;
                    }
                    if (num < lowLedger) {
                        LedgNum = num + num % 2;
                    }
                    System.out.println("WEHEREBABY");
                    extendedLedgers[count] = getResources().getDrawable(R.drawable.blackline3);
                    extendedLedgers[r].setBounds((int) (noteX + (noteWidth / 2)), height / 2 - lineHeight - ((LedgNum - noteCenter) * Yoffset), noteX + (int) (1.5 * noteWidth) + 8, height / 2 + lineHeight - ((LedgNum - noteCenter) * Yoffset));

                    extendedLedgers[r].draw(canvas);
                    r++;
                }
            }
        }


        System.out.println("Qtest91: " + Arrays.toString(mAccidentals));
       int [] Aoff = returnAccidentalsOffset(mAccidentals, offsetList,newNoteList);

       // System.out.println("Qtest91: " + Arrays.toString(newNoteList));
        for (int i = 0; i < mCustomImage.length; i++) {

            int Xoffset = (int) ((noteWidth / 1.14) * p[i]); // this will need a separate function , returnOffsetList
            int Accoffset = (int) ((noteWidth / 1.14));
            int XInitialoffset = (int) (noteWidth / 2);
            //doubleflat
            int doubleflatXoffset = (int) (noteWidth/1.7);
            int doubleflatYLowoffset =(int)( 1.3 * Yoffset);
            int doubleflatYHighoffset =  (int)( 2.4 * Yoffset);
            //flat
            int flatYLowoffset = (int)( 1.1 * Yoffset);
            int flatYHighoffset = (int)( 2.2 * Yoffset);
            int flatXoffset=(int) (noteWidth/2.9);
            //
            //sharp
            int sharpYoffset = ((int)(1.6*Yoffset));
            int sharpXoffset=(int) (noteWidth/2.8);
            //
            //doublesharp
            int doubleSharpXoffset=Yoffset;
            int doubleSharpYoffset = Yoffset;
            //
            int sharpX = (int) (0.4 * Xoffset);
            int num = newNoteList[i]; //new noteList may need to be sorted
            int initialYoffset = (int) (.06 * height - (Yoffset * (num - 23)));
            //  System.out.println("Note:" + num);
            int noteY = height / 2  - ((num - noteCenter) * Yoffset);
            int accidentalX = noteX - noteWidth ; //removed '+ Xoffset' to a avoid accidentals being pulled over, i havent tested if this causes problems tho

            mCustomImage[i].setBounds(noteX - XInitialoffset + Xoffset, noteY-Yoffset, noteX + XInitialoffset + Xoffset, noteY+Yoffset);
            mCustomImage[i].draw(canvas);

            //int flatX=noteWidth/2;
                if(mAccidentals[i]==-2){ //doubleflat
                    int center = accidentalX - (int)(width/100);
                    mAccidentalImage[i].setBounds( center + (Aoff[i]*Accoffset) - doubleflatXoffset, noteY-doubleflatYHighoffset, center + (Aoff[i]*Accoffset)+ doubleflatXoffset, noteY+doubleflatYLowoffset);
                    mAccidentalImage[i].draw(canvas);
                }else if(mAccidentals[i]==-1) { //flat
                    int center = accidentalX;
                    mAccidentalImage[i].setBounds(center + (Aoff[i]*Accoffset) - flatXoffset, noteY-flatYHighoffset, center + (Aoff[i]*Accoffset)+ flatXoffset, noteY+flatYLowoffset);
                    mAccidentalImage[i].draw(canvas);
                }else if(mAccidentals[i]==0){//natural
                    //do nothing for now
                }else if(mAccidentals[i]==1){ //sharp
                    int center = accidentalX;
                    mAccidentalImage[i].setBounds(center + (Aoff[i]*Accoffset) - sharpXoffset, noteY-sharpYoffset, center + (Aoff[i]*Accoffset)+ sharpXoffset, noteY+sharpYoffset);
                    mAccidentalImage[i].draw(canvas);
                }else if(mAccidentals[i]==2){//doublesharp
                    int center = accidentalX;
                    mAccidentalImage[i].setBounds(center + (Aoff[i]*Accoffset) - doubleSharpXoffset, noteY-doubleSharpYoffset, center + (Aoff[i]*Accoffset) + doubleSharpXoffset, noteY+doubleSharpYoffset);
                    mAccidentalImage[i].draw(canvas);
                }

        }

        if (drawingMax) {

            VerticalBracketLine = getResources().getDrawable(R.drawable.blackline3);
            HighBracketLine = getResources().getDrawable(R.drawable.blackline3);
            LowBracketLine = getResources().getDrawable(R.drawable.blackline3);
            int MaxBarHeight;
            int MinBarHeight;

            if (newNoteList.length == 1) {
                MinBarHeight = height / 2 + ((int)(1.85*Yoffset))  - ((newNoteList[0] - noteCenter) * Yoffset);
                MaxBarHeight = height / 2 - ((int)(1.85*Yoffset)) - ((newNoteList[0] - noteCenter) * Yoffset);
            } else{
                MinBarHeight = height / 2 + ((int)(1.85*Yoffset)) - ((newNoteList[0] - noteCenter) * Yoffset);
                MaxBarHeight = height / 2 - ((int)(1.85*Yoffset)) - ((newNoteList[1] - noteCenter) * Yoffset);
        }

            Paint paint = new Paint();
            paint.setColor(Color.BLACK);
            paint.setTextSize(50);
            int numX = ((width-((int)(2*noteWidth)))/2);
            int numY = MaxBarHeight - (noteHeight/4);
            canvas.drawText(Integer.toString(noteCount),numX,numY,paint);
            //draws brackets//

            VerticalBracketLine.setBounds(width/2 - ((int)(1.7*noteWidth)),MaxBarHeight,width/2 - ((int)(1.6*noteWidth)),MinBarHeight);
            HighBracketLine.setBounds(width/2 - ((int)(1.6*noteWidth)),MaxBarHeight,width/2 ,MaxBarHeight + (int)(.15 * noteHeight));
            LowBracketLine.setBounds(width/2 - ((int)(1.6*noteWidth)),MinBarHeight - (int)(.15 * noteHeight),width/2 ,MinBarHeight);
            
            VerticalBracketLine.draw(canvas);
            HighBracketLine.draw(canvas);
            LowBracketLine.draw(canvas);
        }
    }
}

/*
    public MyCanvas(Context context, int n, int r, int l, boolean t , boolean b,boolean[] accidentalKey) {

    zx

    int n = Amount of notes
    int r = range of notes ( from bottom note )
    int l = bottom note
    boolean t = show treble clef
    boolean b = show bass clef
    boolean[] accidentalkey = array that marks i it should have accidental

    //render bars
    //render ledgers
    //render notes using absolute positioning
    //render accidentals using absolute positioning



*/
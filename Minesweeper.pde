import de.bezier.guido.*;
public static final int NUM_ROWS=10;
public static final int NUM_COLS=10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
  mines= new ArrayList<MSButton>();
    //your code to initialize buttons goes here
    buttons=new MSButton[NUM_ROWS][NUM_COLS];
    for (int r=0; r<buttons.length;r++){
      for (int c=0; c<buttons[r].length; c++){
        buttons[r][c]=new MSButton(r,c);
      }
    }
    
  for(int i=0; i<10; i++)  
  setMines();
}
public void setMines()
{
 int MyRow=(int)(Math.random()*NUM_ROWS);
 int MyCol=(int)(Math.random()*NUM_COLS);
  if (!mines.contains(buttons[MyRow][MyCol]))
  mines.add(buttons[MyRow][MyCol]);
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    for (int r=0; r<buttons.length;r++){
      for (int c=0; c<buttons[r].length; c++){
        if (!mines.contains(buttons[r][c])&&buttons[r][c].clicked==false)
        return false;
      }
    }
    return true;
}
public void displayLosingMessage()
{
     for (int r=0; r<4;r++){
      for (int c=0; c<4; c++){
       buttons[r][c].flagged=false; 
      } 
      } 
  for(int i=0; i<mines.size(); i++){
    mines.get(i).clicked=true;
    }
    buttons[0][0].setLabel("y");
    buttons[0][1].setLabel("o");
    buttons[0][2].setLabel("u");
    buttons[1][0].setLabel("l");
    buttons[1][1].setLabel("o");
    buttons[1][2].setLabel("s");
    buttons[1][3].setLabel("e");
}
public void displayWinningMessage()
{
  for (int r=0; r<2;r++){
      for (int c=0; c<3; c++){
       buttons[r][c].flagged=false;
       buttons[r][c].clicked=false; 
      } 
      } 
    buttons[0][0].setLabel("y");
    buttons[0][1].setLabel("o");
    buttons[0][2].setLabel("u");
    buttons[1][0].setLabel("w");
    buttons[1][1].setLabel("i");
    buttons[1][2].setLabel("n");
}
public boolean isValid(int r, int c)
{
    if (r>=0&&c>=0&&r<NUM_ROWS&&c<NUM_COLS)
    return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for (int i=row-1; i<=row+1; i++){
       for (int k=col-1; k<=col+1; k++){
         if (isValid(i,k)){
           if(mines.contains(buttons[i][k]))
           numMines++;
         }
    }
    }
    if(mines.contains(buttons[row][col]))
    numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton==RIGHT){
         if(flagged==true){
         flagged=false;
         clicked=false;}
         else
         flagged=true;
        }
        else if(mines.contains(this))
        displayLosingMessage();
        else if(countMines(myRow,myCol)>0)
        setLabel(countMines(myRow,myCol));
        else{
           if(isValid(myRow,myCol-1)&&buttons[myRow][myCol-1].clicked==false)
    buttons[myRow][myCol-1].mousePressed(); //left
            if(isValid(myRow-1,myCol-1)&&buttons[myRow-1][myCol-1].clicked==false)
    buttons[myRow-1][myCol-1].mousePressed(); //left up
           if(isValid(myRow-1,myCol)&&buttons[myRow-1][myCol].clicked==false)
    buttons[myRow-1][myCol].mousePressed();//up
           if(isValid(myRow-1,myCol+1)&&buttons[myRow-1][myCol+1].clicked==false)
    buttons[myRow-1][myCol+1].mousePressed();//right up
           if(isValid(myRow,myCol+1)&&buttons[myRow][myCol+1].clicked==false)
    buttons[myRow][myCol+1].mousePressed();//right
           if(isValid(myRow+1,myCol+1)&&buttons[myRow+1][myCol+1].clicked==false)
    buttons[myRow+1][myCol+1].mousePressed(); //right down
           if(isValid(myRow+1,myCol)&&buttons[myRow+1][myCol].clicked==false)
    buttons[myRow+1][myCol].mousePressed();//down
           if(isValid(myRow+1,myCol-1)&&buttons[myRow+1][myCol-1].clicked==false)
    buttons[myRow+1][myCol-1].mousePressed();//down left
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this)) 
           fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

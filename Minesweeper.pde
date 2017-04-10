

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 25
public static final int NUM_ROWS = 25;
public static final int NUM_COLS = 25;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;
int activeBombs = 5; //Number of bombs =  difficulty of game

void setup ()
{
    size(400,400);
    textAlign(CENTER,CENTER);
    gameOver = false;
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < NUM_ROWS; rows++)
    {
        for(int cols = 0; cols < NUM_COLS; cols++)
        {
            buttons[rows][cols] = new MSButton(rows,cols);
        }
    }
    bombs = new ArrayList <MSButton>();
    for(int i = 0; i < activeBombs; i ++)
    {
        setBombs();
    }
}
public void setBombs()
{
    int ranRow = (int)(Math.random()*NUM_ROWS);
    int ranCol = (int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[ranRow][ranCol]))
    {
        bombs.add(buttons[ranRow][ranCol]);
    }
}

public void draw ()
{
    if(!gameOver && isWon())
    {
         displayWinningMessage();
    }
    if(keyPressed && key == ENTER)
    {
        setup();
    }
}


public boolean isWon()
{
  for (int i =0; i< bombs.size (); i++) {
    if (bombs.get(i).isMarked() == false) {
      return false;
    }
  }
  return true;
}

public void displayLosingMessage()
{
    for (int i = 0; i < bombs.size(); i++)
    {
        if (bombs.get(i).isClicked() == false)
        {
            bombs.get(i).clicked = true;
        }
    }
    buttons[12][11].setLabel("Y");
    buttons[12][12].setLabel("O");
    buttons[12][13].setLabel("U");
    buttons[12][14].setLabel(" ");
    buttons[12][15].setLabel("L");
    buttons[12][16].setLabel("O");
    buttons[12][17].setLabel("S");
    buttons[12][18].setLabel("T");
}

public void displayWinningMessage()
{ 
    buttons[12][11].setLabel("Y");
    buttons[12][12].setLabel("O");
    buttons[12][13].setLabel("U");
    buttons[12][14].setLabel(" ");
    buttons[12][15].setLabel("W");
    buttons[12][16].setLabel("I");
    buttons[12][17].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
        {
            marked = !marked;
        }
        else if(bombs.contains(buttons[r][c]))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            setLabel((str(countBombs(r,c))));
        }
        else
        {
            for (int i = -1; i <= 1; i++)
            {
                for (int n = -1; n <= 1; n++)
                {
                    if (isValid(r+i, c+n) && !buttons[r+i][c+n].isClicked())
                    {
                        buttons[r+i][c+n].mousePressed();
                    }
                }
            }
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        for (int j = -1; j <= 1; j++)
        {
            for (int k = -1; k <= 1; k++)
            {
                if (isValid(row+j, col+k) && bombs.contains(buttons[row+j][col+k]))
                {
                    numBombs = numBombs + 1;
                }
            }
        }  
        return numBombs;
    }   
}


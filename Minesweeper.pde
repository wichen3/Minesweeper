

import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int rows = 0; rows < 20; rows++)
    {
        for(int cols = 0; cols < 20; cols++)
        {
            buttons[rows][cols] = new MSButton(rows,cols);
            setBombs();
        }
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
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    background(0);
}
public void displayWinningMessage()
{
    //your code here
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
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(keyPressed == true)
        {
            marked = true;
        }
        else if(marked == false)
        {
            clicked = false;
        }
        else if(bombs.contains(buttons[r][c]))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c) > 0)
        {
            buttons[r][c].setLabel("2");
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
        for(int rowAbove = row - 1; rowAbove < row + 1; rowAbove++)
        {
            for(int colBefore = col - 1; colBefore < col + 1; colBefore++)
            {
                if(isValid(rowAbove, colBefore))
                {
                    if(bombs.contains(buttons[rowAbove][colBefore]))
                    {
                        numBombs = numBombs + 1;
                    }
                }
            }
        }
        return numBombs;
    }
}


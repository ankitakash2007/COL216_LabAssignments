
# coding: utf-8

# In[21]:


board = []
points = []
agents = []
turn = 1


# In[22]:


for i in range(64):
    board.append(0)
for i in range(3):
    agents.append(0)
for i in range(2) :
    points.append(0)


# In[23]:


def get(x,y):
    return x*8+y

def print_board():
    print("         1    2    3    4    5    6    7    8\n")
    for i in range(8):
        print "   ",i+1,
        for j in range(8):
            print"  ",agents[board[get(i,j)]],
        print " ",i+1,
        print "\n"
    print("         1    2    3    4    5    6    7    8\n")


# In[24]:


def check_bound(x, y):
    if(x<0 or y<0 or x>7 or y>7):
        return 0
    else :
        return 1


# In[25]:

def check_valid(i , j):
    if((not check_bound(i,j)) or (board[get(i,j)]==turn)):
        return 0
    else:
        return 1

# In[26]:


def recurse_turn(x,y,inc_x,inc_y,set):
    if((not check_bound(x,y)) or board[get(x,y)]==0):
        return 0
    if(board[get(x,y)]==turn):
        return 1
    ans = recurse_turn(x+inc_x,y+inc_y,inc_x,inc_y,set)
    if(ans==1):
        if (set==1):
            board[get(x,y)]=turn
            points[turn-1]+=1
            points[(turn%2)]-=1
        return 1
    else:
        return 0


# In[27]:


def move(i, j, set):
    ans = 0;
    if(check_valid(i-1,j)):
        ans += recurse_turn(i-1,j,-1,0,set)
    if(check_valid(i+1,j)):
        ans += recurse_turn(i+1,j,1,0,set)
    if(check_valid(i,j-1)):
        ans += recurse_turn(i,j-1,0,-1,set)
    if(check_valid(i,j+1)):
        ans += recurse_turn(i,j+1,0,1,set)
    if(check_valid(i+1,j+1)):
        ans += recurse_turn(i+1,j+1,1,1,set)
    if(check_valid(i-1,j-1)):
        ans += recurse_turn(i-1,j-1,-1,-1,set)
    if(check_valid(i+1,j-1)):
        ans += recurse_turn(i+1,j-1,1,-1,set)
    if(check_valid(i-1,j+1)):
        ans += recurse_turn(i-1,j+1,-1,1,set)
    return ans


# In[28]:


def check(agents):
    global turn
    isPossible = 0
    original_turn = turn
    i = j = 0
    cond = i<8 and isPossible == 0
    turn = agents
    while (cond == 1):
        j = 0
        incond = j<8 and isPossible == 0
        while(incond == 1):
            if(board[get(i,j)]==0):
                isPossible = move(i,j,0)
            j+=1;
            incond = j<8 and isPossible == 0
        i+=1
        cond = i<8 and isPossible == 0
    turn = original_turn
    return isPossible

# In[29]:

def play(x, y):
    global turn
    global points
    x-=1
    y-=1
    if((not check_bound(x,y)) or board[get(x,y)]!=0):
        return 0
    isValid = 0
    i = j = 0
    isValid = move(x,y,1)
    if(isValid == 0):
        return 0
    next_turn = (turn%2)+1
    board[get(x,y)] = turn
    points[turn-1]+=1
    if(check(next_turn)):
        turn = next_turn
        return next_turn
    elif(check(turn)):
        printf("Not possible for new turn\n")
        return turn
    else:
        return -1

# In[41]:


#Main Function
end = 0
x = y = 0
board[get(3,3)] = 1
board[get(4,4)] = 1
board[get(3,4)] = 2
board[get(4,3)] = 2

agents[0] = '-'
agents[1] = 'o'
agents[2] = 'x'

print("Let's begin")


while(end==0):
    print_board()
    print "agents ", agents[turn], "'s turn"
    x = input("enter x : ")
    y = input("enter y : ")
    ret = play(x,y)
    if(ret ==0):
        print ("\nPleas Enter a valid move!\n\n")
    elif(ret ==-1):
        print ("Game End!\n")
        end =1


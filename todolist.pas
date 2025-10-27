program TodoList;

{ record is like struct in c }
{ the colon : means has type of, name : type; }
type
   Task	= record	  
	     description : string;
	     completed	 : boolean;
	  end;		 

{ arrays can start at any index }
{ pascal doesn't require a ; after the last dec in a block}
var
   tasks     : array[1..100] of Task;
   taskCount : integer;
   choice    : integer;

{ procedure is a void function } 
{ := is pascal's assignment operator}
procedure ShowMenu;
begin
   writeln;
   writeln('### TODO LIST ###');
   writeln('1. add task');
   writeln('2. view tasks');
   writeln('3. complete task');
   writeln('4. delete task');
   writeln('5. exit');
   writeln('choose: ');
end;

procedure SaveToFile;
var
   f		: text; {text is pascal's file type for .txt files}
   i		: integer;
   completedVal	: integer;
begin
   {assign associates file variable with file name}
   assign(f, 'tasks.txt');
   rewrite(f); {open file for writing; creates new or overwrites existing}

   for i := 1 to taskCount do
      begin
	 { conver boolean to integer; some systems handle booleans differently}
	 if tasks[i].completed then
	    completedVal := 1
	    else
	       completedVal := 0;
	 writeln(f, completedVal);
	 writeln(f, tasks[i].description);
      end;

   close(f);
end;

procedure LoadFromFile;
var
   f		: text;
   completedVal	: integer;

begin
   assign(f, 'tasks.txt');
   {$I-} {turn off i/o error checking, so if the file does not exist, the program wont crash}
   reset(f); {open file for reading}
   {$I+} {turn it back on }

   { 0 is success, non zero an error}
   if IOResult <> 0 then
      exit;

   taskCount := 0;
   {eof(F) = "end of file", it returns true when we reach the file's end}
   while not eof(f) do
      begin
	 inc(taskCount);
	 readln(f, completedVal);
	 {convert integer back to boolean }
	 tasks[taskCount].completed := (completedVal = 1);
	 readln(f, tasks[taskCount].description);
      end;

   close(f);
end;

procedure AddTask;
begin
   if taskCount >= 100 then
      begin
	 writeln('task list is full');
	 exit;
      end;

   {inc(a) is the same as a = a + 1; }
   inc(taskCount);
   write('enter task: ');
   readln(tasks[taskCount].description);
   tasks[taskCount].completed := false;
   SaveToFile;
   writeln('task added!');
end;

procedure ViewTasks;
var
   i : integer;

begin
   if taskCount = 0 then
      begin
	 writeln('no tasks yet');
	 exit;
      end;

   writeln;
   writeln('your tasks:');
   for i := 1 to taskCount do
   begin
      write(i, '. ');
      if tasks[i].completed then
	 write('[X] ')
      else
	 write('[ ] ');
      writeln(tasks[i].description);
   end;
end;

procedure CompleteTask;
var
   num : integer;
begin
   if taskCount = 0 then
      begin
	 writeln('No tasks to complete');
	 exit;
      end;

   ViewTasks;
   write('enter task number to mark complete');
   readln(num);

   if (num < 1) or (num > taskCount) then
      begin
	 writeln('invalid task number');
	 exit;
      end;

   tasks[num].completed := true;
   SaveToFile;
   writeln('task marked as complete');
end;   

procedure DeleteTask;
var
   num, i : integer;

begin
   if taskCount = 0 then
      begin
	 writeln('no tasks to delete');
	 exit;
      end;

   ViewTasks;
   write('enter task number ro delete: ');
   readln(num);

   if (num < 1) or (num > taskCount) then
      begin
	 writeln('invalid  task number');
	 exit;
      end;

   for i := num to taskCount - 1 do
      tasks[i] := tasks[i + 1];

   dec(taskCount);
   SaveToFile;
   writeln('task deleted');
end;
      

begin
   taskCount := 0;
   LoadFromFile;
   repeat
      ShowMenu;
      readln(choice);

      { case statement is like switch in C }
      case choice of
	1 : AddTask;
	2 : ViewTasks;
	3 : CompleteTask;
	4 : DeleteTask;
	5 : writeln('goodbye!');
      else {defaultt case}
	 write('invalid choice');
      end
   until choice = 5;

end.
   

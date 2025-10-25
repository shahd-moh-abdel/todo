program TodoList;

{ record is like struct in c }
{ the colon : means has type of, name : type; }
type
   Task	= record	  
	     description :  string;
	  end;

{ arrays can start at any index }
{ pascal doesn't require a ; after the last dec in a block}
var
   tasks     : array[1..100] of Task;
   taskCount : integer;
   choice    : integer;

{ procedure is a void function } 

procedure ShowMenu;
begin
   writeln;
   writeln('### TODO LIST ###');
   writeln('1. add task');
   writeln('2. view tasks');
   writeln('3. exit');
   writeln('choose: ');
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
      writeln(i, '. ', tasks[i].description);
end;
   

begin
   taskCount := 0;

   repeat
      ShowMenu;
      readln(choice);

      case choice of
	1 : AddTask;
	2 : ViewTasks;
	3 : writeln('goodbye!');
      else
	 write('invalid choice')
      end;
   until choice = 3;

end.
   

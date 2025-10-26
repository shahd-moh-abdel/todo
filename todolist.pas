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
   writeln('3. delete task');
   writeln('4. exit');
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
   writeln('task deleted');
end;
      

begin
   taskCount := 0;

   repeat
      ShowMenu;
      readln(choice);

      case choice of
	1 : AddTask;
	2 : ViewTasks;
	3 : DeleteTask;
	4 : writeln('goodbye!');
      else
	 write('invalid choice')
      end;
   until choice = 3;

end.
   

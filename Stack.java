import java.util.LinkedList;

public class Stack<T>
{
    LinkedList<T> s; 
    public Stack(){
           s = new LinkedList<T>();
    }
    
    public boolean isEmpty(){
        if(s.size() == 0){
            return true;
        }
        else{
            return false;
        }
    }

    public void push(T e){
        s.add(e);
    }
    
    public T peek(){
        return s.peekLast();
    }
    
    public T pop(){
        return s.pollLast();
    }
}

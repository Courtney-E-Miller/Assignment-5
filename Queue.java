import java.util.LinkedList;
public class Queue<T>
{
    LinkedList<T> q;
    public Queue()
    {
        q = new LinkedList<T>();
    }

    public boolean isEmpty(){
        if(q.size() == 0){
            return true;
        }
        else{
            return false;
        }
    }
    
    public void add(T e){
        q.addLast(e);
    }
    
    public T peek(){
        return q.peekFirst();
    }
    
    public T poll(){
        return q.pollFirst();
    }
}

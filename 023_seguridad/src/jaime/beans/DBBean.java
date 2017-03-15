package jaime.beans;


/**
 * Session Bean implementation class DBBean
 */
public class DBBean implements java.io.Serializable {

	int id;
	String url;
	
    /**
     * Default constructor. 
     */
    public DBBean() {
        super();
    }
    
    public int getId(){
    	return this.id;
    }
    
    public void setId(int newId){
    	this.id = newId;
    }
    
    public String getUrl(){
    	return this.url;
    }
    
    public void setUrl(String newUrl){
    	this.url = newUrl;
    }

    public void test(){
    	System.out.println(this.id);
    	System.out.println(this.url);
    }
    
}

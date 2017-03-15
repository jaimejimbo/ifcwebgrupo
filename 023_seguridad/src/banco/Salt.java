package banco;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

/**
 * Session Bean implementation class Salt
 */
@Stateless
@LocalBean
public class Salt implements SaltRemote, SaltLocal {

    /**
     * Default constructor. 
     */
    public Salt() {
        // TODO Auto-generated constructor stub
    }

}

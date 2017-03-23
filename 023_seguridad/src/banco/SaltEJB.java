package banco;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;

/**
 * Session Bean implementation class SaltEJB
 */
@Stateless
@LocalBean
public class SaltEJB implements SaltEJBRemote, SaltEJBLocal {

    /**
     * Default constructor. 
     */
    public SaltEJB() {
        // TODO Auto-generated constructor stub
    }

}

package banco;

import javax.ejb.Local;

@Local
public interface SaltLocal {
	public String hash(String pwd, String salt, String email);
}

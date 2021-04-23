package common;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class TempFileRenamePolicy implements FileRenamePolicy {

	@Override
	public File rename(File f) {
		File newFile = null;

		// 확장자 구하기
		String oldName = f.getName();
		String ext = "";
		int dot = oldName.lastIndexOf(".");
		if (dot > -1)
			ext = oldName.substring(dot);

		String newName = "temp" + ext;
		
		//파라미터로 전달받은 File f를 읽어서 newName인 파일로 저장하자
		newFile = new File(f.getParent(), newName);
		
		//finally 안해도됨 JDK 1.7부터 사용 가능
		try(BufferedReader br = new BufferedReader(new FileReader(f));
			BufferedWriter bw = new BufferedWriter(new FileWriter(newFile));
		){
			String data = null;
			
			while((data = br.readLine()) != null) {
				System.out.println(data+":");
				bw.write(data+"\n"); //readLine은 개행문자는 가져오지 않아서 추가해줌
			}
			
		}catch (Exception e) {
		}

		return newFile;
	}

}

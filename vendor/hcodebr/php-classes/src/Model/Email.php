<?php 

namespace Hcode\Model;

use \Hcode\DB\Sql;
use \Hcode\Model;
use \Hcode\Mailer;
use \Hcode\Model\User;

class Email extends Model {

		public function saveEmail($email)
	{

		$sql = new Sql();

		$sql->query("INSERT INTO tb_emails VALUES('',':email')",
			[
				':email'=>$email

			]);




	}

}

 ?>
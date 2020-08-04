<?php
namespace App\Models;
use CodeIgniter\Model;

class ConfigModel extends Model
{
    public function configEdit($data)
    {	
		$builder = $this->db->table('config');
		foreach($data as $key=>$value){
			$res   = $builder->select('*')
					->where(['name'=>$key])
					->get()
					->getRowArray();
			if(empty($res)){
				//insert
				$builder->set('name', $key);
				$builder->set('value', $value);
				$builder->insert();
			}else{
				//update
				$builder->where('name', $key);
				$builder->update(['value'=>$value]);
			}
		}

        return 1;
    }
	public function getData(){
		$builder = $this->db->table('config');
		$res   = $builder->select('*')
							->where(['deleted'=>0])
							->get()
							->getResultArray();
		$result = [];					
		foreach($res as $key=>$value){
			$result[$value['name']] = $value['value'];
		}
        return $result;
	}
}


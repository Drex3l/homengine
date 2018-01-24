<?php
abstract class dbAccess{
    public static function recordExisits($relation, $field, $value) {
        $sql = "SELECT COUNT($field) RECORDS FROM $relation WHERE $field = :value";
        $params = array(':value'=>$value);
        return dbHandler::DQL($sql,$params)['RECORDS'];
    }
    public static function deleteRecord($relation, $id, $value) {
        $sql = "DELETE FROM $relation WHERE $id = :value";
        $params = array(':value'=>$value);
        dbHandler::Execute($sql,$params);
    }
    public static function clearField($relation, array $fields, $default, $key, $value) {
         $length = count($fields);
            $x = 0;
            $subjects = "";
            foreach ($fields as $field) {
                $x++;
                if ($x < $length) {
                    $subjects .= "$field = :empty" . ' , ';
                } else {
                    $subjects .= "$field = :empty";
                }
            }
            $sql = "UPDATE $relation SET $subjects WHERE $key = :value";
            $params = array(':value'=>$value,':empty'=>$default);
            dbHandler::Execute($sql,$params);
    }
    public static function getEnumDropDown($relation, $enum) {
        $sql = "SHOW COLUMNS FROM $relation WHERE FIELD = :enum";
        $params = array(':enum' => $enum);
        $record = dbHandler::DQL($sql, $params);
        $type = substr($record["Type"], 6, (strlen($record["Type"]) - 8));
        return explode("','", $type);
    }

}
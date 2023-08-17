//SPDX-License-Identifier: UNIDENTIFIED
pragma solidity ^0.8.0;
contract MedicalLedger {

 struct Doctor {
 string name;
 string qualification;
 string workPlace;
 }
 
 struct Patient {
 string name;
 uint age;
 string[] diseases;
 uint[] medicineIds;
 }
 
 struct Medicine {
 uint id;
 string name;
 string expiryDate;
 uint dose;
 uint price;
 }
 
 uint public medicineId = 1;
 uint public doctorId = 1;
 uint public patientId = 1;
 
 mapping(uint => Doctor) public doctors;
 mapping(address => Patient) public patients;
 mapping(uint => Medicine) public medicines;
 
 function registerDoctor(string memory _name, string memory _qualification, string memory _workPlace) public {
 uint _doctorid = doctorId;
 doctors[_doctorid] = Doctor(_name, _qualification, _workPlace);
 }
 function registerPatient(string memory _name, uint _age) public {
 patients[msg.sender] = Patient(_name, _age, new string[](0), new uint[](0));
 }
 function addPatientDisease(string memory _disease) public {
 patients[msg.sender].diseases.push(_disease);
 }
 function addMedicine(uint id,string memory _name, string memory _expiryDate, uint _dose, uint _price) public {
 medicineId = id;
 medicines[medicineId] = Medicine(medicineId, _name, _expiryDate, _dose, _price);
 medicineId++;
 }
 function prescribeMedicine(uint _id, address _patient) public {
 patients[_patient].medicineIds.push(_id);
 }
 function updatePatientAge(uint _age) public {
 patients[msg.sender].age = _age;
 }
 function viewPatientData() public view returns (uint, uint, string memory, string[] memory) {
 Patient storage patient = patients[msg.sender];
 return (patient.age, bytes(patient.name).length, patient.name, patient.diseases);
 }
 
 function viewMedicineDetails(uint _id) public view returns (string memory, string memory, uint, uint) {
 Medicine storage medicine = medicines[_id];
 return (medicine.name, medicine.expiryDate, medicine.dose, medicine.price);
 }
 
 function viewPatientDataByDoctor(address _patient) public view returns (uint, uint, string memory, string[] memory) {
 Patient storage patient = patients[_patient];
 return (patient.age, bytes(patient.name).length, patient.name, patient.diseases);
 }
 
 function viewPrescribedMedicine(address _patient) public view returns (uint[] memory) {
 return patients[_patient].medicineIds;
 }
 
 function viewDoctorDetails(uint _id) public view returns (uint id,string memory, string memory, string memory) {
 id = _id;
 Doctor storage doctor = doctors[_id];
 return (id ,doctor.name, doctor.qualification, doctor.workPlace);
 }
}

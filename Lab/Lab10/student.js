function Student(firstName, lastName, studentID) {

    this.firstName = firstName;
    this.lastName = lastName;
    this.studentID = studentID;

    this.display = function () {

        console.log(`${this.firstName}, ${this.lastName}, ${this.studentID}`);
    }

}

 

var studentArray = [];

studentArray.push(new Student("Dinh", "Nguyen", 0));
studentArray.push(new Student("Robert", "Green", 1));

studentArray[1].display()


let tan = new Student("Tan", "Nguyen", 4)
tan.graduated = true
console.log(tan)

 

var Mark = {

    firstName: "Mark",
    lastName: "Pham",
    studentID: 3,

    __proto__: new Student

};

console.log(Mark)
Mark.display()

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_task/models/task_model.dart';

class FirebaseFunctions{

static CollectionReference<TaskModel> getTasksCollection()=>
    FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
        fromFirestore: (docSnapshot,_)=>TaskModel.fromJson(docSnapshot.data()!),
        toFirestore: (taskModel,_)=>taskModel.toJson());


 static Future<void> addTaskToFireStore(TaskModel task)async{

  CollectionReference<TaskModel> tasksCollection=getTasksCollection();

 DocumentReference<TaskModel>docRef= tasksCollection.doc();

 task.id=docRef.id;
 docRef.set(task);

  }

static Future<List<TaskModel>>getAllTasksFromFireStore()async{
  CollectionReference<TaskModel> tasksCollection=getTasksCollection();

 QuerySnapshot<TaskModel>querySnapShot =await tasksCollection.get();
 return querySnapShot.docs.map((doc)=>doc.data()).toList();

}


  static Future<void> deleteTskFromFireStore(String taskId){
   CollectionReference<TaskModel> tasksCollection=getTasksCollection();
   return tasksCollection.doc(taskId).delete();



  }

// static Future<void> updateTskFromFireStore(String taskId){
//  CollectionReference<TaskModel> tasksCollection=getTasksCollection();
//  return tasksCollection.doc(taskId).update(data);
//
//
//
// }
}
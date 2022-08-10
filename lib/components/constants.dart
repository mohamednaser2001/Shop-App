
const String LOGIN ='login';
const String REGISTER ='register';
const String HOME ='home';
const String CATEGORIES ='categories';
const String FAVORITES ='favorites';
const String SEARCH ='products/search';

String ? token;
/*
* IconButton(
            color: Colors.red,
            onPressed: (){
              CacheHelper.removeData(key: 'token').then((value) {
                if(value==true){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context)=> LoginScreen()),
                          (route) => false
                  );
                }
              });
            },
            icon: Icon(Icons.ac_unit_rounded),),*/
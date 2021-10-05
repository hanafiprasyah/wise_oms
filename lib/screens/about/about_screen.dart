import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}
class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, size){
          if(size.deviceScreenType == DeviceScreenType.mobile){
            return OrientationLayoutBuilder(
                portrait: (_) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    bottomOpacity: 0.0,
                    leading: IconButton(
                      icon: Icon(CupertinoIcons.back,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          size: 32),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: Desc()
                ),
            );
          }
          if(size.deviceScreenType == DeviceScreenType.desktop){
            return Center(child: Text("This app does not support Desktop Screen"));
          }
          if(size.deviceScreenType == DeviceScreenType.tablet){
            return Center(child: Text("This app does not support Tablet Screen"));
          }
          if(size.deviceScreenType == DeviceScreenType.watch){
            return Center(child: Text("This app does not support Watch Screen"));
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.red,
            alignment: Alignment.center,
            child: Center(
              child: Text("Error : Please call the developer ASAP. Email : prasyah1998@gmail.com"),),);
        }
    );
  }
}

class Desc extends StatefulWidget {
  const Desc({Key? key}) : super(key: key);

  @override
  _DescState createState() => _DescState();
}
class _DescState extends State<Desc> {

  String airnav       = 'assets/logos/airnav.png';
  String alfamart     = 'assets/logos/alfamart.svg';
  String baf          = 'assets/logos/baf.png';
  String banknagari   = 'assets/logos/banknagari.png';
  String bankpermata  = 'assets/logos/bankpermata.png';
  String bca          = 'assets/logos/bca.png';
  String cimbniaga    = 'assets/logos/cimbniaga.png';
  String danamon      = 'assets/logos/danamon.svg';
  String freeport     = 'assets/logos/freeport.png';
  String kai          = 'assets/logos/kai.png';
  String lionair      = 'assets/logos/lionair.png';
  String mercedes     = 'assets/logos/mercedes.png';
  String nutrifood    = 'assets/logos/nutrifood.png';
  String pertamina    = 'assets/logos/pertamina.png';
  String siloam       = 'assets/logos/siloam.png';
  String sumselbabel  = 'assets/logos/sumselbabel.png';
  String wilmar       = 'assets/logos/wilmar.png';

  List<String> logoCustomer = [
  'assets/logos/airnav.png',
  'assets/logos/baf.png',
  'assets/logos/banknagari.png',
  'assets/logos/bankpermata.png',
  'assets/logos/bca.png',
  'assets/logos/cimbniaga.png',
  'assets/logos/freeport.png',
  'assets/logos/kai.png',
  'assets/logos/lionair.png',
  'assets/logos/mercedes.png',
  'assets/logos/nutrifood.png',
  'assets/logos/pertamina.png',
  'assets/logos/siloam.png',
  'assets/logos/sumselbabel.png',
  'assets/logos/wilmar.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      maintainBottomViewPadding: false,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'wiselogo',
                child: Material(
                  type: MaterialType.transparency,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Image.asset('assets/images/logowise.png',width: 128,height: 128,)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("ABOUT US", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text("Wibawa Electrical Solutions (WISE) is a provider of comprehensive electrical protection solutions (End to End Solution) based on electrical technology innovation. WISE is the right choice to assist you in providing the right and accurate solution to secure your important devices, worth the high investment and must operate continuously without stopping from problems that arise due to electrical disturbances. Born since 2017, supported by experts in their fields who are able to become solution partners for customers in an effort to overcome electrical problems that occur repeatedly or have not been able to find solutions to the core of customers’ electrical problems so far.",
                      style: TextStyle(fontSize: 14,color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.grey.shade800),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,),
              ),
              SizedBox(height: 20,),
              Center(
                child: Text('Our Customer',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      CarouselSlider.builder(
                          itemCount: logoCustomer.length,
                          itemBuilder: (context, index, id){
                            return Container(
                              margin: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  image: AssetImage(logoCustomer[index]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              height: 180,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              aspectRatio: 16/9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: Duration(milliseconds: 500),
                              autoPlayInterval: Duration(milliseconds: 1500),
                              scrollPhysics: BouncingScrollPhysics(),
                              viewportFraction: 0.7
                          )
                      ),
                      // CarouselSlider(
                      //     items: [
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(airnav),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       SvgPicture.asset(alfamart,fit: BoxFit.fill,width: 100,height: 100,),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(baf),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(banknagari),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(bankpermata),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(bca),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(cimbniaga),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       SvgPicture.asset(danamon,fit: BoxFit.fill,width: 100,height: 100,),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(freeport),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(kai),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(lionair),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(mercedes),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(nutrifood),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(pertamina),
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(siloam),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(sumselbabel),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.all(6.0),
                      //         decoration: BoxDecoration(
                      //           color: Colors.transparent,
                      //           image: DecorationImage(
                      //             image: AssetImage(wilmar),
                      //             fit: BoxFit.fill,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //     options: CarouselOptions(
                      //         height: 180,
                      //         enlargeCenterPage: false,
                      //         autoPlay: true,
                      //         aspectRatio: 16/9,
                      //         autoPlayCurve: Curves.fastOutSlowIn,
                      //         enableInfiniteScroll: true,
                      //         autoPlayAnimationDuration: Duration(milliseconds: 500),
                      //         autoPlayInterval: Duration(milliseconds: 1500),
                      //         scrollPhysics: BouncingScrollPhysics(),
                      //         viewportFraction: 0.7
                      //     )
                      // )
                    ],
                  )
                // StaggeredGridView.countBuilder(
                //     crossAxisCount: 2,
                //     crossAxisSpacing: 10,
                //     mainAxisSpacing: 12,
                //     itemCount: imageList.length,
                //     itemBuilder: (context, index){
                //       return Container(
                //         decoration: BoxDecoration(
                //           color: Colors.transparent,
                //           borderRadius: BorderRadius.all(Radius.circular(15))
                //         ),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.all(Radius.circular(15)),
                //           child: FadeInImage.memoryNetwork(
                //               placeholder: kTransparentImage,
                //               image: imageList[index],
                //               fit: BoxFit.fill,
                //           ),
                //         ),
                //       );
                //     },
                //     staggeredTileBuilder: (index){
                //       return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                //     }
                // )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  _CustomerState createState() => _CustomerState();
}
class _CustomerState extends State<Customer> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      maintainBottomViewPadding: false,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.transparent,
        margin: EdgeInsets.all(12),
        child: ListView(
          children: [
            CarouselSlider(
                items: [
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/airnav.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('assets/logos/alfamart.svg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/baf.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/banknagari.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/bankpermata.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/bca.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/cimbniaga.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('assets/logos/danamon.svg',),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/freeport.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/kai.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/lionair.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/mercedes.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/nutrifood.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/pertamina.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/siloam.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/sumselbabel.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage('https://wiseoms.000webhostapp.com/logos/wilmar.png',),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
                options: CarouselOptions(
                  height: 180,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 500),
                  viewportFraction: 0.7
                )
            )
          ],
        )
        // StaggeredGridView.countBuilder(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 10,
        //     mainAxisSpacing: 12,
        //     itemCount: imageList.length,
        //     itemBuilder: (context, index){
        //       return Container(
        //         decoration: BoxDecoration(
        //           color: Colors.transparent,
        //           borderRadius: BorderRadius.all(Radius.circular(15))
        //         ),
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.all(Radius.circular(15)),
        //           child: FadeInImage.memoryNetwork(
        //               placeholder: kTransparentImage,
        //               image: imageList[index],
        //               fit: BoxFit.fill,
        //           ),
        //         ),
        //       );
        //     },
        //     staggeredTileBuilder: (index){
        //       return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
        //     }
        // )
      ),
    );
  }
}

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}
class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

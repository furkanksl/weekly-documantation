
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: AnimatedListWidget(),
));

class AnimatedListWidget extends StatefulWidget {
  @override
  _AnimatedListWidgetState createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();


  List<String> _data = ['Item 1', 'Item 2', 'Item 3', 'Last Item'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AnimatedList Widget',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: Utils.ubuntuRegularFont),
        ),
      ),
      body: AnimatedList(
        // Key ile herhangi bir yerden listeyi çağırıyor
        key: _listKey,
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_data[index], animation, index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () => _insertSingleItem(),
      ),
    );
  }

  Widget _buildItem(String item, Animation animation, int index) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        elevation: 5.0,
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),
          ),
          trailing: GestureDetector(
            child: Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
            onTap: (){
              _removeSingleItems(index);
            },
          ),
        ),
      ),
    );
  }


  // List'e eleman ekleyen method
  void _insertSingleItem() {
    int insertIndex;
    if(_data.length > 0 ) {
      insertIndex = _data.length;
    }else{
      insertIndex = 0;
    }
    String item = "Item ${insertIndex + 1}";
    _data.insert(insertIndex, item);
    _listKey.currentState.insertItem(insertIndex);
  }

  // Card silen method
  void _removeSingleItems(int removeAt) {
    int removeIndex = removeAt;
    String removedItem = _data.removeAt(removeIndex);

    AnimatedListRemovedItemBuilder builder = (context, animation) {
      // Card oluşturan method
      return _buildItem(removedItem, animation, removeAt);
    };
    _listKey.currentState.removeItem(removeIndex, builder);
  }
}
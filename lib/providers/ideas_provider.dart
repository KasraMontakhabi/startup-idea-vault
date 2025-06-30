import 'package:flutter/material.dart';
import '../models/startup_idea.dart';
import '../data/dummy_ideas.dart';

class IdeasProvider extends ChangeNotifier {
  List<StartupIdea> _ideas = [];
  
  List<StartupIdea> get ideas => [..._ideas];
  
  IdeasProvider() {
    // Initialize with dummy data
    _ideas = [...dummyIdeas];
  }
  
  void addIdea(StartupIdea idea) {
    _ideas.add(idea);
    notifyListeners();
  }
  
  void addIdeaAt(int index, StartupIdea idea) {
    if (index >= 0 && index <= _ideas.length) {
      _ideas.insert(index, idea);
      notifyListeners();
    }
  }
  
  void removeIdea(int index) {
    if (index >= 0 && index < _ideas.length) {
      _ideas.removeAt(index);
      notifyListeners();
    }
  }
  
  void removeIdeaByTitle(String title) {
    _ideas.removeWhere((idea) => idea.title == title);
    notifyListeners();
  }
  
  StartupIdea? getRandomIdea() {
    if (_ideas.isEmpty) return null;
    final randomIndex = DateTime.now().millisecondsSinceEpoch % _ideas.length;
    return _ideas[randomIndex];
  }
  
  List<StartupIdea> searchIdeas(String query) {
    if (query.isEmpty) return ideas;
    
    final lowercaseQuery = query.toLowerCase();
    return _ideas.where((idea) {
      return idea.title.toLowerCase().contains(lowercaseQuery) ||
             idea.description.toLowerCase().contains(lowercaseQuery) ||
             idea.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }
}
class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final double score;
  final String category;

  Answer(this.answerText, this.score, this.category);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here
//1
  list.add(Question(
    "I am clear about my feelings.",
    [
      Answer("Strongly Disagree", 1, 'CLARITY'),
      Answer("Disagree", 2, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 4, 'CLARITY'),
      Answer("Strongly Agree", 5, 'CLARITY'),
    ],
  ));
  //3
  list.add(Question(
    "I pay attention to how I feel.",
    [
      Answer("Strongly Disagree", 1, 'AWARENESS'),
      Answer("Disagree", 2, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 4, 'AWARENESS'),
      Answer("Strongly Agree", 5, 'AWARENESS'),
    ],
  ));
  //4
  list.add(Question(
    "I experience my emotions as overwhelming and out of control.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //5
  list.add(Question(
    "I have no idea how I am feeling.",
    [
      Answer("Strongly Disagree", 5, 'CLARITY'),
      Answer("Disagree", 4, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 2, 'CLARITY'),
      Answer("Strongly Agree", 1, 'CLARITY'),
    ],
  ));
  //6
  list.add(Question(
    "I have difficulty making sense out of my feelings.",
    [
      Answer("Strongly Disagree", 5, 'CLARITY'),
      Answer("Disagree", 4, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 2, 'CLARITY'),
      Answer("Strongly Agree", 1, 'CLARITY'),
    ],
  ));
  //7
  list.add(Question(
    "I am attentive to my feelings.",
    [
      Answer("Strongly Disagree", 1, 'AWARENESS'),
      Answer("Disagree", 2, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 4, 'AWARENESS'),
      Answer("Strongly Agree", 5, 'AWARENESS'),
    ],
  ));
  //8
  list.add(Question(
    "I know exactly how I am feeling.",
    [
      Answer("Strongly Disagree", 1, 'CLARITY'),
      Answer("Disagree", 2, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 4, 'CLARITY'),
      Answer("Strongly Agree", 5, 'CLARITY'),
    ],
  ));
  //9
  list.add(Question(
    "I care about what I am feeling.",
    [
      Answer("Strongly Disagree", 1, 'AWARENESS'),
      Answer("Disagree", 2, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 4, 'AWARENESS'),
      Answer("Strongly Agree", 5, 'AWARENESS'),
    ],
  ));
  //10
  list.add(Question(
    "I am confused about how I feel.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //12
  list.add(Question(
    "When I'm upset, I acknowledge my emotions.",
    [
      Answer("Strongly Disagree", 1, 'AWARENESS'),
      Answer("Disagree", 2, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 4, 'AWARENESS'),
      Answer("Strongly Agree", 5, 'AWARENESS'),
    ],
  ));
  //14
  list.add(Question(
    "When I'm upset, I become angry with myself for feeling that way.",
    [
      Answer("Strongly Disagree", 5, 'NONACCEPTANCE'),
      Answer("Disagree", 4, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 2, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 1, 'NONACCEPTANCE'),
    ],
  ));
  //15
  list.add(Question(
    "When I'm upset, I become embarrassed for feeling that way.",
    [
      Answer("Strongly Disagree", 5, 'NONACCEPTANCE'),
      Answer("Disagree", 4, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 2, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 1, 'NONACCEPTANCE'),
    ],
  ));
  //16
  list.add(Question(
    "When I'm upset, I have difficulty getting work done.",
    [
      Answer("Strongly Disagree", 5, 'GOALS'),
      Answer("Disagree", 4, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 2, 'GOALS'),
      Answer("Strongly Agree", 1, 'GOALS'),
    ],
  ));
  //17
  list.add(Question(
    "When I'm upset, I become out of control.",
    [
      Answer("Strongly Disagree", 5, 'IMPULSE'),
      Answer("Disagree", 4, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 2, 'IMPULSE'),
      Answer("Strongly Agree", 1, 'IMPULSE'),
    ],
  ));
  //19
  list.add(Question(
    "When I'm upset, I believe that I will remain that way for a long time",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //20
  list.add(Question(
    "When I'm upset, I believe that I'll end up feeling very depressed.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //21
  list.add(Question(
    "When I'm upset, I believe that my feelings are valid and important.",
    [
      Answer("Strongly Disagree", 1, 'AWARENESS'),
      Answer("Disagree", 2, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 4, 'AWARENESS'),
      Answer("Strongly Agree", 5, 'AWARENESS'),
    ],
  ));
  //22
  list.add(Question(
    "When I'm upset, I have difficulty focusing on other things.",
    [
      Answer("Strongly Disagree", 5, 'GOALS'),
      Answer("Disagree", 4, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 2, 'GOALS'),
      Answer("Strongly Agree", 1, 'GOALS'),
    ],
  ));
  //23
  list.add(Question(
    "When I'm upset, I feel out of control.",
    [
      Answer("Strongly Disagree", 5, 'IMPULSE'),
      Answer("Disagree", 4, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 2, 'IMPULSE'),
      Answer("Strongly Agree", 1, 'IMPULSE'),
    ],
  ));
  //24
  list.add(Question(
    "When I'm upset, I can still get things done.",
    [
      Answer("Strongly Disagree", 1, 'GOALS'),
      Answer("Disagree", 2, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 4, 'GOALS'),
      Answer("Strongly Agree", 5, 'GOALS'),
    ],
  ));
  //25
  list.add(Question(
    "When I'm upset, I feel ashamed with myself for feeling that way.",
    [
      Answer("Strongly Disagree", 5, 'NONACCEPTANCE'),
      Answer("Disagree", 4, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 2, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 1, 'NONACCEPTANCE'),
    ],
  ));
  //26
  list.add(Question(
    "When I'm upset, I know that I can find a way to eventually feel better.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //27
  list.add(Question(
    "When I'm upset, I feel like I am weak.",
    [
      Answer("Strongly Disagree", 5, 'NONACCEPTANCE'),
      Answer("Disagree", 4, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 2, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 1, 'NONACCEPTANCE'),
    ],
  ));
  //28
  list.add(Question(
    "When I'm upset, I feel like I can remain in control of my behaviors.",
    [
      Answer("Strongly Disagree", 5, 'IMPULSE'),
      Answer("Disagree", 4, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 2, 'IMPULSE'),
      Answer("Strongly Agree", 1, 'IMPULSE'),
    ],
  ));
  //29
  list.add(Question(
    "When I'm upset, I feel guilty for feeling that way.",
    [
      Answer("Strongly Disagree", 5, 'NONACCEPTANCE'),
      Answer("Disagree", 4, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 2, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 1, 'NONACCEPTANCE'),
    ],
  ));
  //30
  list.add(Question(
    "When I'm upset, I have difficulty concentrating.",
    [
      Answer("Strongly Disagree", 5, 'GOALS'),
      Answer("Disagree", 4, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 2, 'GOALS'),
      Answer("Strongly Agree", 1, 'GOALS'),
    ],
  ));
  //31
  list.add(Question(
    "When I'm upset, I have difficulty controlling my behaviors.",
    [
      Answer("Strongly Disagree", 5, 'IMPULSE'),
      Answer("Disagree", 4, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 2, 'IMPULSE'),
      Answer("Strongly Agree", 1, 'IMPULSE'),
    ],
  ));
  //32
  list.add(Question(
    "When I'm upset, I believe that there is nothing I can do to make myself feel better.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //33
  list.add(Question(
    "When I'm upset, I become irritated with myself for feeling that way.",
    [
      Answer("Strongly Disagree", 5, 'NONACCEPTANCE'),
      Answer("Disagree", 4, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 2, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 1, 'NONACCEPTANCE'),
    ],
  ));
  //34
  list.add(Question(
    "When I'm upset, I start to feel very bad about myself.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //35
  list.add(Question(
    "When I'm upset, I believe that wallowing in it is all I can do.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //37
  list.add(Question(
    "When I'm upset, I lose control over my behaviors.",
    [
      Answer("Strongly Disagree", 5, 'IMPULSE'),
      Answer("Disagree", 4, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 2, 'IMPULSE'),
      Answer("Strongly Agree", 1, 'IMPULSE'),
    ],
  ));
  //38
  list.add(Question(
    "When I'm upset, I have difficulty thinking about anything else.",
    [
      Answer("Strongly Disagree", 5, 'GOALS'),
      Answer("Disagree", 4, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 2, 'GOALS'),
      Answer("Strongly Agree", 1, 'GOALS'),
    ],
  ));
  //39
  list.add(Question(
    "When I'm upset, I take time to figure out what I'm really feeling.",
    [
      Answer("Strongly Disagree", 1, 'AWARENESS'),
      Answer("Disagree", 2, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 4, 'AWARENESS'),
      Answer("Strongly Agree", 5, 'AWARENESS'),
    ],
  ));
  //40
  list.add(Question(
    "When I'm upset, it takes me a long time to feel better.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //41
  list.add(Question(
    "When I'm upset, my emotions feel overwhelming.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  return list;
}

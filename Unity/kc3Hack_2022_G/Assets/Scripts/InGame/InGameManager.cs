using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


// ゲーム内処理用スクリプト
public class InGameManager : MonoBehaviour
{

    // [SerializeField]を付けて変数を宣言すると、public の変数でなくても Unity Editor側（inspector内）から中身を指定することが出来るようになる。
    [SerializeField] int score = 0;     // 現在のスコア
    [SerializeField] Text scoreText;    // スコアを表示するテキスト


    // 0.02秒に1回（デフォルト値）の間隔で実行する
    void FixedUpdate()
    {
        // scoreを文字列型にしてテキストに反映させる
        scoreText.text = score.ToString();
    }

}

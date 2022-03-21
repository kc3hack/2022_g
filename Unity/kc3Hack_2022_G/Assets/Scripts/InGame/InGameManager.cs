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

    List<Item> items;
    Item currentItem;
    GameObject currentItemGO;

    int stopFlames;


    void Start()
    {
        items = new List<Item>();
        stopFlames = 0;
    }


    // 0.02秒に1回（デフォルト値）の間隔で実行する
    private void FixedUpdate()
    {
        bool stopping = true;

        if (currentItem.moving == true)
        {
            foreach (Item item in items)
            {
                if (item.moving == true)
                {
                    stopping = false;
                }
            }

            if (stopping == true)
            {
                stopFlames++;
            } else
            {
                stopFlames = 0;
            }

            if (stopFlames >= 100)
            {
                serveNextItem();
            }
        }

        if (stopFlames >= 100) {
            stopFlames = 100;
        }

        // scoreを文字列型にしてテキストに反映させる
        scoreText.text = score.ToString();
    }


    private void serveNextItem() {
        Debug.Log("Serve Next");
    }

}

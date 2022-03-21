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

    List<Item> items;   // 今存在するアイテムを管理する用のリスト
    [SerializeField] Item currentItem;   // 現在操作しているアイテム
    [SerializeField] GameObject currentItemGO;   // 現在操作しているアイテムのGameObject

    int stopFlames; // 連続で静止しているフレーム数


    void Start()
    {
        items = new List<Item>();
        stopFlames = 0;

        // 開始1.0f秒後に、最初のアイテムを生成する
        //Invoke("serveNextItem", 1.0f);

        items.Add(currentItem);
    }


    // 0.02秒に1回（デフォルト値）の間隔で実行する
    private void FixedUpdate()
    {
        bool stopping = true;   // 「全てのアイテムが止まっている」

        if (currentItem != null) {

            // 現在操作するアイテムが、操作済みならば判定に入る
            if (currentItem.bePlaced == true)
            {
                // itemsの全てについて判定
                foreach (Item item in items)
                {
                    // もしitemのmovingがtrueなら
                    if (item.moving == true)
                    {
                        // 「動いているアイテムがある」
                        stopping = false;
                    }
                }

                // もし判定後もstoppingがtrueのままなら
                if (stopping == true)
                {
                    // 静止しているフレーム数を+1
                    stopFlames++;
                } else // そうでないなら
                {
                    // 判定やり直し
                    stopFlames = 0;
                }

                // もし2秒以上、静止したままだったら
                if (stopFlames >= 100)
                {
                    // 次のアイテムを生成する
                    serveNextItem();
                }
            }
        }


        // int型の整数がオーバーフロー（管理できる整数の値の範囲を超える）するのを防ぐ
        if (stopFlames >= 100) {
            stopFlames = 100;
        }

        // scoreを文字列型にしてテキストに反映させる
        scoreText.text = score.ToString();
    }


    // （次のアイテムを生成する）
    private void serveNextItem() {
        Debug.Log("Serve Next");
    }

}

using System.Collections;
using System.Collections.Generic;
using UnityEngine;


// アイテムの特徴用スクリプト
public class Item : MonoBehaviour
{

    Rigidbody2D rb; // Rigidbody2Dコンポーネントをスクリプトで操作する為の変数
    bool moved;     // 「既に操作されたかどうか」
    int itemScore;  // （各種アイテムが持つ、固有のスコア　の予定）


    // 最初に実行される
    private void Start()
    {
        // このスクリプトがアタッチされているGameObjectの、Rigidbody2Dコンポーネントを代入する
        rb = GetComponent<Rigidbody2D>();

        // Rigidbody2D の bodyType を Kinematic に変更する
        rb.bodyType = RigidbodyType2D.Kinematic;

        // 「最初はまだ操作されていない」
        moved = false;
    }


    // マウス（もしくは指）でドラッグされている間、毎フレーム処理
    void OnMouseDrag()
    {
        // もし操作済みでないならば
        if (moved == false)
        {
            // 画面上のマウスの座標を取り出す
            Vector2 pointScreen = new Vector2(Input.mousePosition.x, Input.mousePosition.y);

            // マウスの座標を、ゲーム内の座標に変換する
            Vector2 pointWorld = Camera.main.ScreenToWorldPoint(pointScreen);

            // 変換した座標の位置に、アイテムを動かす
            this.transform.position = pointWorld;
        }
    }


    // もしドラッグされ終わったら
    private void OnMouseUp()
    {
        // もし操作済みでないならば
        if (moved == false)
        {
            // Rigidbody2D の bodyType を Dynamic に変更する
            rb.bodyType = RigidbodyType2D.Dynamic;

            // 「操作済み」
            moved = true;
        }
    }

}

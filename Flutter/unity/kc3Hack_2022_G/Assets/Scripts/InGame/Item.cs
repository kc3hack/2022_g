using System.Collections;
using System.Collections.Generic;
using UnityEngine;


// アイテムの特徴用スクリプト
public class Item : MonoBehaviour
{

    Rigidbody2D rb; // Rigidbody2Dコンポーネントをスクリプトで操作する為の変数
    public bool bePlaced;     // 「既に操作されたかどうか」
    public int itemBaseScore;  // 各種アイテムが持つ、固有のスコア
    float speed;    // スピード
    public bool moving; // 「動いているかどうか」
    public string itemType; // どの種類のアイテムなのかを情報として持つ変数
    public bool beDraged; // 「ドラッグされたかどうか」
    public float height; // y座標を格納する為の変数


    // 最初に実行される
    void Start()
    {
        // このスクリプトがアタッチされているGameObjectの、Rigidbody2Dコンポーネントを代入する
        rb = GetComponent<Rigidbody2D>();

        // Rigidbody2D の bodyType を Kinematic に変更する
        rb.bodyType = RigidbodyType2D.Kinematic;

        // 「最初はまだ操作されていない」
        bePlaced = false;

        // 「最初はまだ動いていない」
        moving = false;

        // 「最初はまだドラッグされていない」
        beDraged = false;
    }


    void Update() {
        // 今のスピード
        speed = rb.velocity.magnitude;

        // もし操作済みなら判定
        if (bePlaced == true)
        {   
            // もしスピードが0.1f以上ならば
            if (speed >= 0.1f)
            {
                // 「動いている」
                moving = true;
            } else // もしそうでないならば
            {
                // 動いていない
                moving = false;
            }
        }

        height = transform.position.y;
    }


    // マウス（もしくは指）でドラッグされている間、毎フレーム処理
    void OnMouseDrag()
    {
        // もし操作済みでないならば
        if (bePlaced == false)
        {
            // 「ドラッグされた」
            beDraged = true;
            
            // 画面上のマウスの座標を取り出す
            Vector2 pointScreen = new Vector2(Input.mousePosition.x, Input.mousePosition.y);

            // マウスの座標を、ゲーム内の座標に変換する
            Vector2 pointWorld = Camera.main.ScreenToWorldPoint(pointScreen);

            // 変換した座標の位置に、アイテムを動かす
            this.transform.position = pointWorld;
        }
    }


    // もしドラッグされ終わったら
    void OnMouseUp()
    {
        // 操作終了
        finishOperate();
    }


    // 操作終了時の処理
    public void finishOperate()
    {
        // もし操作済みでないならば
        if (bePlaced == false)
        {
            // Rigidbody2D の bodyType を Dynamic に変更する
            rb.bodyType = RigidbodyType2D.Dynamic;

            // 「操作済み」
            bePlaced = true;
        }
    }

}

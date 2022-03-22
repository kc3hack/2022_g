using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;//scenemanagerをつかうため


// ゲーム内処理用スクリプト
public class InGameManager : MonoBehaviour
{
    public UserInformationManager uim;  // TitleSceneから存在するUserInformationManagerを格納する為の変数

    // [SerializeField]を付けて変数を宣言すると、public の変数でなくても Unity Editor側（inspector内）から中身を指定することが出来るようになる。
    private long score = 0;     // 現在のスコア
    [SerializeField] Text scoreText;    // スコアを表示するテキスト

    List<Item> items;   // 今存在するアイテムを管理する用のリスト
    Item currentItem;   // 現在操作しているアイテム
    GameObject currentItemGO;   // 現在操作しているアイテムのGameObject

    int stopFlames; // 連続で静止しているフレーム数

    [SerializeField] GameObject[] itemPrefabs;  // アイテムのprefabを管理する用の配列
    List<GameObject> canUseItemGOList;  // 1回以上購入した、利用可能なアイテムのみを管理する用のリスト

    // アイテム回転用ボタンを格納する為の変数
    [SerializeField] private GameObject rotateButtonL;  // 左（反時計回り用）
    [SerializeField] private GameObject rotateButtonR;  // 右（時計回り用）

    [SerializeField] private DropTrigger dt;    // DropTriggerの状態を格納する為の変数

    // ゲームオーバー
    private GameObject GameOverText;//ゲームオーバー時のテキスト 
    private GameObject GameOverScoreText;//スコア用
    private GameObject GameOverScoreItemsText;//落としたアイテムの数用
    private GameObject GameOverButton;//ゲームオーバー時のリスタートボタン
    public int DropItems=0;//落としたアイテムの数を保管(DropTriggerにも処理を追加)


    void Start()
    {
        // TitleSceneから存在する"UserInformationManager"GameObjectの、UserInformationManagerコンポーネントを格納する
        uim = GameObject.Find("UserInformationManager").GetComponent<UserInformationManager>();

        ////ゲームオーバー
        GameOverText=GameObject.Find("GameOverText");
        GameOverScoreText=GameObject.Find("GameOverScoreText");
        GameOverScoreItemsText=GameObject.Find("GameOverScoreItemsText");
        GameOverButton=GameObject.Find("GameOverButton");

        GameOverButton.SetActive(false);//RestartButtonを隠す
        ////

        // items、stopFlames　初期化
        items = new List<Item>();
        stopFlames = 0;

        // 購入回数が0より大きい（= 購入したことがある）カテゴリのアイテムだけをリストにまとめる
        canUseItemGOList = new List<GameObject>();
        foreach (GameObject itemGO in itemPrefabs)
        {
            if (itemGO != null)
            {
                if (uim.itemCounts[itemGO.GetComponent<Item>().itemType] > 0)
                {
                    canUseItemGOList.Add(itemGO);
                }
            }
        }

        // scoreを文字列型にしてテキストに反映させる
        scoreText.text = score.ToString();

        // rotateButton 非表示
        rotateButtonL.SetActive(false);
        rotateButtonR.SetActive(false);

        // 開始1.0f秒後に、最初のアイテムを生成する
        Invoke("serveNextItem", 1.0f);
    }


    // 0.02秒に1回（デフォルト値）の間隔で実行する
    private void FixedUpdate()
    {
        // もしまだゲームオーバーになっていないなら
        if (dt.beGameOver == false)
        {
            // currentItemのドラッグがされ始めたら、rotateButtonを非表示にする。
            if (currentItem != null)
            {
                if (currentItem.beDraged == true)
                {
                    rotateButtonL.SetActive(false);
                    rotateButtonR.SetActive(false);
                }
            }


            // アイテム静止判定

            bool stopping = true;   // 「全てのアイテムが止まっている」

            if (currentItem != null)
            {
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
                        addScore();

                        // 次のアイテムを生成する
                        serveNextItem();
                    }
                }
            }
        }


        // int型の整数がオーバーフロー（管理できる整数の値の範囲を超える）するのを防ぐ
        if (stopFlames >= 100) {
            stopFlames = 0;
        }
    }


    // 次のアイテムを生成する
    private void serveNextItem() {
        int randomNumber = Random.Range(0, canUseItemGOList.Count);
        currentItemGO = Instantiate(canUseItemGOList[randomNumber]);
        currentItem = currentItemGO.GetComponent<Item>();

        // itemsにcurrentItemを追加
        items.Add(currentItem);

        // rotateButton 表示
        rotateButtonL.SetActive(true);
        rotateButtonR.SetActive(true);
    }


    // スコアを加算するメソッド
    private void addScore() {
        if (currentItem != null)
        {
            // （itemBaseScore + 2 * （購入回数 - 1））を加算　（一旦）
            score += currentItem.itemBaseScore + 2 * uim.itemCounts[currentItem.itemType];

            // scoreを文字列型にしてテキストに反映させる
            scoreText.text = score.ToString();
        }
    }

    // もし引数があった時にはこっちを実行（オーバーロード）
    public void addScore(int num)
    {
        // numをscoreに加算
        score += num;

        // scoreを文字列型にしてテキストに反映させる
        scoreText.text = score.ToString();
    }


    // currentItemを回転させるメソッド
    public void rotateCurrentItem(int dir)
    {
        if (currentItemGO != null)
        {
            if (currentItem.bePlaced != true)
            {
                currentItemGO.transform.Rotate(new Vector3(0, 0, 30 * dir));
            }
        }
    }


    // ゲームオーバー時の処理
    public void doGameOver()
    {
        Debug.Log("GameOver!");
        GameOverText.GetComponent<Text>().text = "GameOver";//Gameoverを表示
        GameOverScoreText.GetComponent<Text>().text="Your Score\n"+score;//scoreを表示
        GameOverScoreItemsText.GetComponent<Text>().text=$"あなたは\n{DropItems}個の食品を\n無駄にした";//落としたアイテムの数を表示

        GameOverButton.SetActive(true);//ボタンを表示
        
    }

    public void RestartButton()//RestartButtonを押したときの処理
    {
        Debug.Log("Restart");
        SceneManager.LoadScene("GameScene");//GameSceneを読み直す;
    }
    //
}

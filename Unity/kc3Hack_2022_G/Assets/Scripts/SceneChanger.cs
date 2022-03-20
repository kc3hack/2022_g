using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

// シーン遷移処理用スクリプト
public class SceneChanger : MonoBehaviour
{
    // まず最初に実行
    private void Start()
    {
        // このスクリプトがアタッチされたGameObjectが、シーン遷移時に破棄されなくなる
        DontDestroyOnLoad(this);
    }


    // シーン変更用のメソッド  sceneNameで遷移先Scene指定
    public void ChangeScene(string sceneName)
    {
        switch (sceneName)
        {
            case "GameScene":
                // 1.0f秒後、メソッド"ChangeToGameScene"を実行
                Invoke("ChangeToGameScene", 1.0f);
                break;
            default:
                // ログに"SceneNameError"と表示
                Debug.Log("SceneNameError");
                break;
        }

    }


    // GameSceneに遷移する用のメソッド
    public void ChangeToGameScene()
    {
        // シーン"GameScene"に遷移
        SceneManager.LoadScene("GameScene");
    }

}

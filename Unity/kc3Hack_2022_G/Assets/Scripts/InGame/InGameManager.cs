using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class InGameManager : MonoBehaviour
{
    [SerializeField] int score = 0;
    [SerializeField] Text scoreText;

    void Start()
    {
        
    }

    void FixedUpdate()
    {
        scoreText.text = score.ToString();
    }
}

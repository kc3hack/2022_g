using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HowToPlayManager : MonoBehaviour
{ 
    public bool beingHowToPlay;
    [SerializeField] private GameObject howToPlay;

    private void Start()
    {
        beingHowToPlay = false;
    }


    public void popHowToPlay()
    {
        beingHowToPlay = true;
        howToPlay.SetActive(true);
    }


    public void closeHowToPlay()
    {
        beingHowToPlay = false;
        howToPlay.SetActive(false);
    }

}
